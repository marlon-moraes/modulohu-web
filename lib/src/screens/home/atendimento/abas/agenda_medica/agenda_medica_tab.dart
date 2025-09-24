// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:components/components.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/agenda_medica.dart';
import 'package:modulohu_web/src/models/anexo.dart';
import 'package:modulohu_web/src/models/atendimento.dart';
import 'package:modulohu_web/src/models/evento.dart';
import 'package:modulohu_web/src/models/procedimento_agenda_medica.dart';
import 'package:modulohu_web/src/models/user_action.dart';
import 'package:modulohu_web/src/screens/home/atendimento/abas/atendimento/abas/anexos_tab.dart';
import 'package:modulohu_web/src/screens/home/dialog/dialog_listagem.dart';
import 'package:modulohu_web/src/services/api/req/agenda_medica_req.dart';
import 'package:modulohu_web/src/services/api/req/especialidade_req.dart';
import 'package:modulohu_web/src/services/api/req/especializacao_req.dart';
import 'package:modulohu_web/src/services/api/req/procedimento_req.dart';
import 'package:modulohu_web/src/utils/constants.dart';

class AgendaMedicaTab extends StatefulWidget {
  final UserAction pessoaLogada;
  final String idAtendimentoCRA;
  final Atendimento atendimentoCarregado;
  final List<Anexo> anexos;
  final bool isModoInclusao;
  final bool isCanceladoFinalizado;

  const AgendaMedicaTab({
    super.key,
    required this.pessoaLogada,
    required this.idAtendimentoCRA,
    required this.atendimentoCarregado,
    required this.anexos,
    required this.isModoInclusao,
    required this.isCanceladoFinalizado,
  });

  @override
  State<AgendaMedicaTab> createState() => _AgendaMedicaTabState();
}

class ProcedimentosDataSource extends DataTableSource {
  final List<ProcedimentoAgendaMedica> _list;
  final Size size;
  final Function(ProcedimentoAgendaMedica) onSelect;
  final VoidCallback alterarModo;
  final BuildContext context;

  ProcedimentosDataSource(this._list, this.size, this.onSelect, this.alterarModo, this.context);

  ProcedimentoReq procedimentoReq = ProcedimentoReq();

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _list.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow? getRow(int index) {
    final item = _list[index];

    Future<void> excluirProcedimento(String id, int index) async {
      await procedimentoReq.reqExcluirProcedimento(id, context);
      _list.removeAt(index);
      notifyListeners();
    }

    return DataRow(
      color: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) => index.isEven ? Colors.grey.withValues(alpha: 0.1) : null),
      cells: [
        DataCell(
          Tooltip(
            message: item.codigo?.toString(),
            child: SizedBox(width: size.width * 0.1, child: Text(item.codigo?.toString() ?? '', overflow: TextOverflow.clip, maxLines: 2)),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          Tooltip(
            message: item.procedimentoNome,
            child: SizedBox(width: size.width * 0.3, child: Text(item.procedimentoNome ?? '', overflow: TextOverflow.ellipsis, maxLines: 2)),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          Tooltip(
            message: 'Excluir Procedimento',
            child: SizedBox(
              width: size.width * 0.1,
              child: InkWell(onTap: () => excluirProcedimento(item.id.toString(), index), child: Icon(Icons.delete, color: Colors.red)),
            ),
          ),
        ),
      ],
      onSelectChanged: (_) {
        onSelect(item);
        alterarModo();
      },
    );
  }
}

class _AgendaMedicaTabState extends State<AgendaMedicaTab> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late final TabController _innerTabController;
  var idEspecialidadeController = TextEditingController();
  var nomeEspecialidadeController = TextEditingController();
  var idEspecializacaoController = TextEditingController();
  var nomeEspecializacaoController = TextEditingController();
  var idProcedimentoController = TextEditingController();
  var nomeProcedimentoController = TextEditingController();
  var observacaoController = TextEditingController();
  var procedimentoSelecionado = ProcedimentoAgendaMedica();
  List<Evento> eventos = [];
  List<ProcedimentoAgendaMedica> procedimentos = [];
  List<AgendaMedica> agendasMedicas = [];
  RetornoAtendimento? _selectedValue;
  var isModoInclusaoProcedimento = true;
  var barraCarregamento = false;
  AgendaMedicaReq agendaMedicaReq = AgendaMedicaReq();
  EspecialidadeReq especialidadeReq = EspecialidadeReq();
  EspecializacaoReq especializacaoReq = EspecializacaoReq();
  ProcedimentoReq procedimentoReq = ProcedimentoReq();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    var agendamedica = AgendaMedica();
    var procedimentoAgendaMedica = ProcedimentoAgendaMedica();

    Future<void> incluirProcedimento() async {
      if (!barraCarregamento) {
        _formKey.currentState!.save();
        agendamedica.idEmp = widget.pessoaLogada.usuario?.empresa?.id;
        agendamedica.idUni = widget.pessoaLogada.unidades?.first.idUni;
        agendamedica.especialidadeAutoId = int.tryParse(idEspecialidadeController.text);
        agendamedica.especialidadeNome = nomeEspecialidadeController.text;
        agendamedica.idAtendimentoCRA = widget.idAtendimentoCRA;
        agendamedica.idEspecializacao = idEspecializacaoController.text;
        agendamedica.observacao = observacaoController.text;
        agendamedica.retornoAtendimento = _selectedValue?.name;
        agendamedica.idUsuInc = widget.pessoaLogada.usuario?.id;
        agendamedica.idUsuAlt = widget.pessoaLogada.usuario?.id;
        procedimentoAgendaMedica.idEmp = widget.pessoaLogada.usuario?.empresa?.id;
        procedimentoAgendaMedica.idUni = widget.pessoaLogada.unidades?.first.idUni;
        procedimentoAgendaMedica.procedimentoCodigo = int.tryParse(idProcedimentoController.text);
        procedimentoAgendaMedica.procedimentoNome = nomeProcedimentoController.text;
        procedimentoAgendaMedica.idUsuInc = widget.pessoaLogada.usuario?.id;
        procedimentoAgendaMedica.idUsuAlt = widget.pessoaLogada.usuario?.id;
        _mostrarBarraCarregamento();
        var res = await procedimentoReq.reqIncluirProcedimento(agendamedica, procedimentoAgendaMedica, context);
        if (res.id != null) {
          setState(() => procedimentos.add(res));
          _limparCampos();
        }
        _mostrarBarraCarregamento();
      }
    }

    Future<void> alterarProcedimento() async {
      if (!barraCarregamento) {
        _formKey.currentState!.save();
        procedimentoAgendaMedica.idEmp = widget.pessoaLogada.usuario?.empresa?.id;
        procedimentoAgendaMedica.idUni = widget.pessoaLogada.unidades?.first.idUni;
        procedimentoAgendaMedica.procedimentoCodigo = int.tryParse(idProcedimentoController.text);
        procedimentoAgendaMedica.procedimentoNome = nomeProcedimentoController.text;
        procedimentoAgendaMedica.idUsuInc = widget.pessoaLogada.usuario?.id;
        procedimentoAgendaMedica.idUsuAlt = widget.pessoaLogada.usuario?.id;
        procedimentoAgendaMedica.id = procedimentoSelecionado.id;
        procedimentoAgendaMedica.codigo = procedimentoSelecionado.codigo;
        procedimentoAgendaMedica.dtInc = procedimentoSelecionado.dtInc;
        procedimentoAgendaMedica.dtAlt = DateTime.now().toString();
        _mostrarBarraCarregamento();
        await procedimentoReq.reqAlterarProcedimento(procedimentoAgendaMedica, context);
        _mostrarBarraCarregamento();
      }
    }

    Future<void> alterarAgendaMedica() async {
      if (!barraCarregamento) {
        _formKey.currentState!.save();
        agendamedica.idEmp = widget.pessoaLogada.usuario?.empresa?.id;
        agendamedica.idUni = widget.pessoaLogada.unidades?.first.idUni;
        agendamedica.especialidadeAutoId = int.tryParse(idEspecialidadeController.text);
        agendamedica.especialidadeNome = nomeEspecialidadeController.text;
        agendamedica.idAtendimentoCRA = widget.idAtendimentoCRA;
        agendamedica.idEspecializacao = idEspecializacaoController.text;
        agendamedica.observacao = observacaoController.text;
        agendamedica.retornoAtendimento = _selectedValue?.name;
        agendamedica.idUsuInc = widget.pessoaLogada.usuario?.id;
        agendamedica.idUsuAlt = widget.pessoaLogada.usuario?.id;
        agendamedica.id = agendasMedicas.first.id;
        agendamedica.codigo = agendasMedicas.first.codigo;
        agendamedica.dtInc = agendasMedicas.first.dtInc;
        agendamedica.dtAlt = DateTime.now().toString();
        _mostrarBarraCarregamento();
        await agendaMedicaReq.reqAlterarAgendaMedica(agendamedica, context);
        _mostrarBarraCarregamento();
      }
    }

    Widget especialidade() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              controller: nomeEspecialidadeController,
              text: 'Especialidade',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado) {
                  final res = await especialidadeReq.reqListarEspecialidade(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogListagem(
                        title: 'Especialidade',
                        list: res,
                        id: idEspecialidadeController,
                        cod: TextEditingController(),
                        nome: nomeEspecialidadeController,
                        pessoaLogada: widget.pessoaLogada,
                        contrato: TextEditingController(),
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget especializacao() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              controller: nomeEspecializacaoController,
              text: 'Especialização',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado) {
                  final res = await especializacaoReq.reqListarEspecializacao(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogListagem(
                        title: 'Especialização',
                        list: res,
                        id: idEspecializacaoController,
                        cod: TextEditingController(),
                        nome: nomeEspecializacaoController,
                        pessoaLogada: widget.pessoaLogada,
                        contrato: TextEditingController(),
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget procedimento() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              controller: nomeProcedimentoController,
              text: 'Procedimento',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogListagem(
                        title: 'Procedimento',
                        list: [],
                        id: idProcedimentoController,
                        cod: TextEditingController(),
                        nome: nomeProcedimentoController,
                        pessoaLogada: widget.pessoaLogada,
                        contrato: TextEditingController(),
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget observacao() {
      return Expanded(
        flex: 4,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              labelStyle: theme.textTheme.bodyMedium,
              border: const OutlineInputBorder(),
              labelText: 'Observação',
              isDense: true,
            ),
            enabled: !widget.isCanceladoFinalizado,
            controller: observacaoController,
            maxLines: 3,
          ),
        ),
      );
    }

    Widget retorno() {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: DropdownButtonFormField<RetornoAtendimento>(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              labelStyle: theme.textTheme.bodyMedium,
              border: const OutlineInputBorder(),
              labelText: 'Retorno Atendimento',
              isDense: true,
            ),
            items:
                RetornoAtendimento.values.map((RetornoAtendimento value) {
                  return DropdownMenuItem<RetornoAtendimento>(value: value, child: Text(getRetornoAtendimentoName(value)));
                }).toList(),
            onChanged: (RetornoAtendimento? newValue) => setState(() => _selectedValue = newValue),
            initialValue: _selectedValue,
          ),
        ),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          DefaultTabController(
            length: 2,
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: theme.colorScheme.primary), borderRadius: BorderRadius.circular(4)),
              child: Column(
                children: [
                  TabBar(
                    labelStyle: TextStyle(color: theme.colorScheme.tertiary, fontWeight: FontWeight.bold, fontSize: 16),
                    tabs: [Tab(text: 'Dados Gerais'), Tab(text: 'Anexos')],
                  ),
                  Divider(),
                  SizedBox(
                    height: Responsive.isLargeScreen(context) ? 554 : 688,
                    child: TabBarView(
                      children: [
                        //? DADOS GERAIS
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Column(
                            children: [
                              if (Responsive.isLargeScreen(context))
                                Column(
                                  children: [
                                    Row(children: [Expanded(child: especialidade()), Expanded(child: especializacao())]),
                                    Row(children: [Expanded(child: procedimento())]),
                                  ],
                                ),
                              if (!Responsive.isLargeScreen(context)) Column(children: [especialidade(), especializacao(), procedimento()]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(8),
                                        child: InkWell(
                                          onTap: () => !widget.isCanceladoFinalizado && isModoInclusaoProcedimento ? incluirProcedimento() : null,
                                          child: Ink(
                                            decoration: BoxDecoration(
                                              color: !widget.isCanceladoFinalizado && isModoInclusaoProcedimento ? theme.colorScheme.secondary : Colors.grey,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Icon(Icons.note_add, color: theme.colorScheme.onSecondary),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(8),
                                        child: InkWell(
                                          onTap: () => !widget.isCanceladoFinalizado && !isModoInclusaoProcedimento ? alterarProcedimento() : null,
                                          child: Ink(
                                            decoration: BoxDecoration(
                                              color: !widget.isCanceladoFinalizado && !isModoInclusaoProcedimento ? theme.colorScheme.tertiary : Colors.grey,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Icon(Icons.edit_document, color: theme.colorScheme.onTertiary),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(8),
                                        child: InkWell(
                                          onTap: () => _limparCampos(),
                                          child: Ink(
                                            decoration: BoxDecoration(color: theme.colorScheme.primary, borderRadius: BorderRadius.circular(4)),
                                            child: Icon(color: theme.colorScheme.onPrimary, Icons.cleaning_services_rounded),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(color: theme.colorScheme.outline, borderRadius: BorderRadius.circular(4)),
                                        width: Responsive.isLargeScreen(context) ? size.width * 0.6 : size.width - 70,
                                        margin: EdgeInsets.fromLTRB(4, 8, 8, 0),
                                        child: ListView(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          children: [
                                            PaginatedDataTable(
                                              showFirstLastButtons: true,
                                              showCheckboxColumn: false,
                                              horizontalMargin: 10,
                                              columnSpacing: 10,
                                              rowsPerPage: 4,
                                              columns: [
                                                DataColumn(label: Expanded(child: Center(child: Text('Código')))),
                                                DataColumn(label: VerticalDivider()),
                                                DataColumn(label: Expanded(child: Center(child: Text('Procedimento')))),
                                                DataColumn(label: VerticalDivider()),
                                                DataColumn(label: Expanded(child: Center(child: Text('')))),
                                              ],
                                              source: ProcedimentosDataSource(procedimentos, size, _onSelect, _alterarModo, context),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (Responsive.isLargeScreen(context))
                                    Button(
                                      buttonColor: !widget.isCanceladoFinalizado && !isModoInclusaoProcedimento ? theme.colorScheme.tertiary : Colors.grey,
                                      onPressed: () => !widget.isCanceladoFinalizado && !isModoInclusaoProcedimento ? alterarAgendaMedica() : null,
                                      contentColor: theme.colorScheme.onTertiary,
                                      text: 'Atualizar',
                                    ),
                                ],
                              ),
                              if (!Responsive.isLargeScreen(context))
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Button(
                                      buttonColor: !widget.isCanceladoFinalizado && !isModoInclusaoProcedimento ? theme.colorScheme.tertiary : Colors.grey,
                                      onPressed: () => !widget.isCanceladoFinalizado && !isModoInclusaoProcedimento ? alterarAgendaMedica() : null,
                                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      contentColor: theme.colorScheme.onTertiary,
                                      text: 'Atualizar',
                                    ),
                                  ],
                                ),
                              Padding(padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4), child: loadingBar(barraCarregamento)),
                              Column(
                                children: [
                                  Row(children: [observacao()]),
                                  Row(children: [retorno()]),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //? ANEXOS
                        AnexosTab(
                          pessoaLogada: widget.pessoaLogada,
                          atendimentoCarregado: widget.atendimentoCarregado,
                          isModoInclusao: widget.isModoInclusao,
                          isCanceladoFinalizado: widget.isCanceladoFinalizado,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    idEspecialidadeController.dispose();
    nomeEspecialidadeController.dispose();
    idEspecializacaoController.dispose();
    nomeEspecializacaoController.dispose();
    idProcedimentoController.dispose();
    nomeProcedimentoController.dispose();
    observacaoController.dispose();
    _innerTabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _innerTabController = TabController(length: 2, vsync: this);
    _carregarDados();
  }

  void _alterarModo() {
    setState(() => isModoInclusaoProcedimento = false);
  }

  Future<void> _carregarDados() async {
    var resAgendaMedica = await agendaMedicaReq.reqListarAgendaMedica(widget.idAtendimentoCRA, context);
    if (!mounted) return;
    setState(() => agendasMedicas = resAgendaMedica);
    if (agendasMedicas.isNotEmpty) {
      var resProcedimento = await procedimentoReq.reqListarProcedimento(agendasMedicas.first.id ?? '', context);
      if (!mounted) return;
      setState(() => procedimentos = resProcedimento);
    } else {
      setState(() => procedimentos = []);
    }
  }

  void _limparCampos() {
    idEspecialidadeController.clear();
    nomeEspecialidadeController.clear();
    idEspecializacaoController.clear();
    nomeEspecializacaoController.clear();
    idProcedimentoController.clear();
    nomeProcedimentoController.clear();
    observacaoController.clear();
    setState(() {
      _selectedValue = null;
      isModoInclusaoProcedimento = true;
    });
  }

  void _mostrarBarraCarregamento() {
    setState(() => barraCarregamento = !barraCarregamento);
  }

  void _onSelect(ProcedimentoAgendaMedica procedimento) {
    idProcedimentoController.text = procedimento.procedimentoCodigo.toString();
    nomeProcedimentoController.text = procedimento.procedimentoNome ?? '';
    setState(() => procedimentoSelecionado = procedimento);
  }
}
