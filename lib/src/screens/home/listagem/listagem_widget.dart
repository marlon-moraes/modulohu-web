// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/atendimento.dart';
import 'package:modulohu_web/src/models/atendimento_sc.dart';
import 'package:modulohu_web/src/models/status.dart';
import 'package:modulohu_web/src/models/user_action.dart';
import 'package:modulohu_web/src/screens/home/dialog/dialog_listagem.dart';
import 'package:modulohu_web/src/services/api/req/assunto_req.dart';
import 'package:modulohu_web/src/services/api/req/atendimento_req.dart';
import 'package:modulohu_web/src/services/api/req/responsavel_req.dart';
import 'package:modulohu_web/src/services/api/req/status_req.dart';
import 'package:modulohu_web/src/services/api/req/tipo_atendimento_req.dart';
import 'package:modulohu_web/src/utils/shared_pref.dart';

final _sharedPref = SharedPref();

class ListagemWidget extends StatefulWidget {
  final UserAction pessoaLogada;

  const ListagemWidget({super.key, required this.pessoaLogada});

  @override
  State<ListagemWidget> createState() => _ListagemWidgetState();
}

class ListDataSource extends DataTableSource {
  final List<Atendimento> _list;
  final Size size;
  final BuildContext context;

  ListDataSource(this._list, this.size, this.context);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _list.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow? getRow(int index) {
    final item = _list[index];

    return DataRow(
      color: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) => index.isEven ? Colors.grey.withValues(alpha: 0.1) : null),
      cells: [
        DataCell(
          SizedBox(
            width: Responsive.isLargeScreen(context) ? size.width * 0.1 : size.width * 0.25,
            child: Text(item.protocolo ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          SizedBox(
            width: Responsive.isLargeScreen(context) ? size.width * 0.1 : size.width * 0.25,
            child: Text(item.beneficiarioNome ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          SizedBox(
            width: Responsive.isLargeScreen(context) ? size.width * 0.1 : size.width * 0.25,
            child: Text(dateFormatter(item.dtSolicitacao ?? ''), overflow: TextOverflow.ellipsis, maxLines: 2),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          SizedBox(
            width: Responsive.isLargeScreen(context) ? size.width * 0.1 : size.width * 0.25,
            child: Text(item.tipo?.nome ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          SizedBox(
            width: Responsive.isLargeScreen(context) ? size.width * 0.1 : size.width * 0.25,
            child: Text(item.responsavel?.nome ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          SizedBox(
            width: Responsive.isLargeScreen(context) ? size.width * 0.1 : size.width * 0.25,
            child: Text(item.status?.nome ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          SizedBox(
            width: Responsive.isLargeScreen(context) ? size.width * 0.1 : size.width * 0.25,
            child: Text(item.prestadorNome ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
          ),
        ),
      ],
      onSelectChanged: (_) async {
        await _sharedPref.save('protocolo', item.protocolo ?? '');
        context.go('/home/atendimento');
      },
    );
  }
}

class _ListagemWidgetState extends State<ListagemWidget> {
  final _formKey = GlobalKey<FormState>();
  Timer? _dadosTimer;
  var _atendimentos = <Atendimento>[];
  bool _sortAscending = true;
  int? _sortColumnIndex;
  final idTipoAtendimentoController = TextEditingController();
  final nomeTipoAtendimentoController = TextEditingController();
  final idAssuntoController = TextEditingController();
  final nomeAssuntoController = TextEditingController();
  final idCanalController = TextEditingController();
  final nomeCanalController = TextEditingController();
  final idCaraterAtendimentoController = TextEditingController();
  final nomeCaraterAtendimentoController = TextEditingController();
  final idStatusController = TextEditingController();
  final nomeStatusController = TextEditingController();
  final idMedSolController = TextEditingController();
  final nomeMedSolController = TextEditingController();
  final idResponsavelController = TextEditingController();
  final nomeResponsavelController = TextEditingController();
  final idBeneficiarioController = TextEditingController();
  final nomeBeneficiarioController = TextEditingController();
  final idProtocoloController = TextEditingController();
  final nomeProtocoloController = TextEditingController();
  final idNomeController = TextEditingController();
  final nomeNomeController = TextEditingController();
  final idDtSolIniController = TextEditingController();
  final nomeDtSolIniController = TextEditingController();
  final idDtSolFinController = TextEditingController();
  final nomeDtSolFinController = TextEditingController();
  var statusCarregado = Status();
  var selecionarTodos = false;
  var barraCarregamento = false;
  AtendimentoReq atendimentoReq = AtendimentoReq();
  AssuntoReq assuntoReq = AssuntoReq();
  ResponsavelReq responsavelReq = ResponsavelReq();
  StatusReq statusReq = StatusReq();
  TipoAtendimentoReq tipoAtendimentoReq = TipoAtendimentoReq();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    var filtro = AtendimentoSC();

    Future<void> consultar() async {
      if (!barraCarregamento) {
        _mostrarBarraCarregamento();
        filtro.protocolo = nomeProtocoloController.text.isNotEmpty ? nomeProtocoloController.text : null;
        filtro.nome = nomeNomeController.text.isNotEmpty ? nomeNomeController.text : null;
        filtro.dtSolicitacaoIni = nomeDtSolIniController.text.isNotEmpty ? dateFormatter2(nomeDtSolIniController.text, false) : null;
        filtro.dtSolicitacaoFim = nomeDtSolFinController.text.isNotEmpty ? dateFormatter2(nomeDtSolFinController.text, false) : null;
        filtro.tipo = idTipoAtendimentoController.text.isNotEmpty ? idTipoAtendimentoController.text : null;
        filtro.assunto = idAssuntoController.text.isNotEmpty ? idAssuntoController.text : null;
        filtro.responsavel = idResponsavelController.text.isNotEmpty ? idResponsavelController.text : null;
        filtro.status = idStatusController.text.isNotEmpty ? idStatusController.text : null;
        filtro.prestador = idMedSolController.text.isNotEmpty ? idMedSolController.text : null;
        var res = await atendimentoReq.reqListarAtendimento(filtro, false, context);
        setState(() => _atendimentos = res);
        _mostrarBarraCarregamento();
      }
    }

    Widget tipoAtendimento() {
      return Row(
        children: [
          Expanded(
            child: FormTextField(
              controller: nomeTipoAtendimentoController,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              text: 'Tipo Atendimento',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                final res = await tipoAtendimentoReq.reqListarTipoAtendimento(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogListagem(
                      title: 'Tipo de Atendimento',
                      list: res,
                      id: idTipoAtendimentoController,
                      cod: TextEditingController(),
                      nome: nomeTipoAtendimentoController,
                      pessoaLogada: widget.pessoaLogada,
                      contrato: TextEditingController(),
                    );
                  },
                );
              },
              child: Ink(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: theme.colorScheme.primary),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget assunto() {
      return Row(
        children: [
          Expanded(
            child: FormTextField(
              controller: nomeAssuntoController,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              text: 'Assunto',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                final res = await assuntoReq.reqListarAssunto(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogListagem(
                      title: 'Assunto',
                      list: res,
                      id: idAssuntoController,
                      cod: TextEditingController(),
                      nome: nomeAssuntoController,
                      pessoaLogada: widget.pessoaLogada,
                      contrato: TextEditingController(),
                    );
                  },
                );
              },
              child: Ink(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: theme.colorScheme.primary),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget status() {
      return Row(
        children: [
          Expanded(
            child: FormTextField(
              controller: nomeStatusController,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              enabled: false,
              text: 'Status',
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                final res = await statusReq.reqListarStatus(true, true, context);
                await showDialog(
                  context: context,
                  builder: (context) {
                    return DialogListagem(
                      title: 'Status',
                      list: res,
                      id: idStatusController,
                      cod: TextEditingController(),
                      nome: nomeStatusController,
                      pessoaLogada: widget.pessoaLogada,
                      contrato: TextEditingController(),
                    );
                  },
                );
                if (nomeStatusController.text.isNotEmpty) setState(() => selecionarTodos = false);
              },
              child: Ink(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: theme.colorScheme.primary),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget medicoSolicitante() {
      return Row(
        children: [
          Expanded(
            child: FormTextField(
              controller: nomeMedSolController,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              text: 'Médico Solicitante',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogListagem(
                      title: 'Médico Solicitante',
                      list: [],
                      id: idMedSolController,
                      cod: TextEditingController(),
                      nome: nomeMedSolController,
                      pessoaLogada: widget.pessoaLogada,
                      contrato: TextEditingController(),
                    );
                  },
                );
              },
              child: Ink(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: theme.colorScheme.primary),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget responsavel() {
      return Row(
        children: [
          Expanded(
            child: FormTextField(
              controller: nomeResponsavelController,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              enabled: false,
              text: 'Responsável',
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                final res = await responsavelReq.reqListarResponsavel(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogListagem(
                      title: 'Responsável',
                      list: res,
                      id: idResponsavelController,
                      cod: TextEditingController(),
                      nome: nomeResponsavelController,
                      pessoaLogada: widget.pessoaLogada,
                      contrato: TextEditingController(),
                    );
                  },
                );
              },
              child: Ink(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: theme.colorScheme.primary),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget protocolo() {
      return FormTextField(
        controller: nomeProtocoloController,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        text: 'Protocolo',
        enabled: true,
      );
    }

    Widget nome() {
      return FormTextField(margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), controller: nomeNomeController, enabled: true, text: 'Nome');
    }

    Widget dtSolIni() {
      return Row(
        children: [
          Expanded(
            child: FormTextField(
              controller: nomeDtSolIniController,
              inputFormatters: [mascaraDataHora],
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              text: 'Dt Solicitação Inicial',
              enabled: true,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () => selecionarData(nomeDtSolIniController, true, context),
              child: Ink(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: theme.colorScheme.primary),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget dtSolFin() {
      return Row(
        children: [
          Expanded(
            child: FormTextField(
              controller: nomeDtSolFinController,
              inputFormatters: [mascaraDataHora],
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              text: 'Dt Solicitação Final',
              enabled: true,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () => selecionarData(nomeDtSolFinController, false, context),
              child: Ink(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: theme.colorScheme.primary),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            if (Responsive.isLargeScreen(context))
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: protocolo()),
                  Expanded(child: nome()),
                  Expanded(child: dtSolIni()),
                  Expanded(child: dtSolFin()),
                  Expanded(child: tipoAtendimento()),
                ],
              ),
            if (Responsive.isLargeScreen(context))
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: assunto()),
                  Expanded(child: responsavel()),
                  Expanded(child: status()),
                  Expanded(child: medicoSolicitante()),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        Checkbox(
                          value: selecionarTodos,
                          onChanged: (value) {
                            setState(() => selecionarTodos = value!);
                            if (value == true) {
                              _limparCampos();
                              consultar();
                            } else {
                              _limparCampos();
                              idStatusController.text = statusCarregado.id ?? '';
                              nomeStatusController.text = statusCarregado.nome ?? '';
                              consultar();
                            }
                          },
                        ),
                        Text('Listar Todos', style: TextStyle(color: theme.colorScheme.onSurface)),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    width: 34,
                    child: InkWell(
                      onTap: () => consultar(),
                      child: Ink(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: theme.colorScheme.tertiary),
                        child: Icon(Icons.arrow_right_alt_rounded, color: theme.colorScheme.onTertiary),
                      ),
                    ),
                  ),
                ],
              ),
            if (!Responsive.isLargeScreen(context))
              Column(
                children: [
                  protocolo(),
                  nome(),
                  dtSolIni(),
                  dtSolFin(),
                  tipoAtendimento(),
                  assunto(),
                  status(),
                  medicoSolicitante(),
                  responsavel(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Row(
                        children: [
                          Checkbox(
                            value: selecionarTodos,
                            onChanged: (value) {
                              setState(() => selecionarTodos = value!);
                              if (value == true) {
                                _limparCampos();
                                consultar();
                              } else {
                                _limparCampos();
                                idStatusController.text = statusCarregado.id ?? '';
                                nomeStatusController.text = statusCarregado.nome ?? '';
                                consultar();
                              }
                            },
                          ),
                          Text('Listar Todos', style: TextStyle(color: theme.colorScheme.onSurface)),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        width: 34,
                        child: InkWell(
                          onTap: () => consultar(),
                          child: Ink(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: theme.colorScheme.tertiary),
                            child: Icon(Icons.arrow_right_alt_rounded, color: theme.colorScheme.onTertiary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            loadingBar(barraCarregamento),
            Container(
              decoration:
                  Responsive.isLargeScreen(context) || _atendimentos.isNotEmpty
                      ? BoxDecoration(color: theme.colorScheme.outline, borderRadius: BorderRadius.circular(4))
                      : null,
              width: Responsive.isLargeScreen(context) ? size.width * 1 : null,
              child:
                  Responsive.isLargeScreen(context)
                      ? ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: [
                          PaginatedDataTable(
                            sortColumnIndex: _sortColumnIndex,
                            sortAscending: _sortAscending,
                            showFirstLastButtons: true,
                            showCheckboxColumn: false,
                            horizontalMargin: 8,
                            columnSpacing: 5,
                            rowsPerPage: 10,
                            columns: [
                              DataColumn(
                                label: SizedBox(
                                  width: Responsive.isLargeScreen(context) ? size.width * 0.1 : size.width * 0.25,
                                  child: Center(child: Text('Protocolo', overflow: TextOverflow.ellipsis, maxLines: 2)),
                                ),
                                onSort: (columnIndex, ascending) {
                                  _sortLargeScreen<String>((Atendimento d) => d.protocolo ?? '', columnIndex, ascending);
                                },
                              ),
                              DataColumn(label: VerticalDivider()),
                              DataColumn(
                                label: SizedBox(
                                  width: Responsive.isLargeScreen(context) ? size.width * 0.1 : size.width * 0.25,
                                  child: Center(child: Text('Nome', overflow: TextOverflow.ellipsis, maxLines: 2)),
                                ),
                                onSort: (columnIndex, ascending) {
                                  _sortLargeScreen<String>((Atendimento d) => d.beneficiarioNome ?? '', columnIndex, ascending);
                                },
                              ),
                              DataColumn(label: VerticalDivider()),
                              DataColumn(
                                label: SizedBox(
                                  width: Responsive.isLargeScreen(context) ? size.width * 0.1 : size.width * 0.25,
                                  child: Center(child: Text('Dt Solicitação', overflow: TextOverflow.ellipsis, maxLines: 2)),
                                ),
                                onSort: (columnIndex, ascending) {
                                  _sortLargeScreen<String>((Atendimento d) => d.dtSolicitacao ?? '', columnIndex, ascending);
                                },
                              ),
                              DataColumn(label: VerticalDivider()),
                              DataColumn(
                                label: SizedBox(
                                  width: Responsive.isLargeScreen(context) ? size.width * 0.1 : size.width * 0.25,
                                  child: Center(child: Text('Tipo Atendimento', overflow: TextOverflow.ellipsis, maxLines: 2)),
                                ),
                                onSort: (columnIndex, ascending) {
                                  _sortLargeScreen<String>((Atendimento d) => d.tipo?.nome ?? '', columnIndex, ascending);
                                },
                              ),
                              DataColumn(label: VerticalDivider()),
                              DataColumn(
                                label: SizedBox(
                                  width: Responsive.isLargeScreen(context) ? size.width * 0.1 : size.width * 0.25,
                                  child: Center(child: Text('Responsável', overflow: TextOverflow.ellipsis, maxLines: 2)),
                                ),
                                onSort: (columnIndex, ascending) {
                                  _sortLargeScreen<String>((Atendimento d) => d.responsavel?.nome ?? '', columnIndex, ascending);
                                },
                              ),
                              DataColumn(label: VerticalDivider()),
                              DataColumn(
                                label: SizedBox(
                                  width: Responsive.isLargeScreen(context) ? size.width * 0.1 : size.width * 0.25,
                                  child: Center(child: Text('Status', overflow: TextOverflow.ellipsis, maxLines: 2)),
                                ),
                                onSort: (columnIndex, ascending) {
                                  _sortLargeScreen<String>((Atendimento d) => d.status?.nome ?? '', columnIndex, ascending);
                                },
                              ),
                              DataColumn(label: VerticalDivider()),
                              DataColumn(
                                label: SizedBox(
                                  width: Responsive.isLargeScreen(context) ? size.width * 0.1 : size.width * 0.25,
                                  child: Center(child: Text('Médico Solicitante', overflow: TextOverflow.ellipsis, maxLines: 2)),
                                ),
                                onSort: (columnIndex, ascending) {
                                  _sortLargeScreen<String>((Atendimento d) => d.prestadorNome ?? '', columnIndex, ascending);
                                },
                              ),
                            ],
                            source: ListDataSource(_atendimentos, size, context),
                          ),
                        ],
                      )
                      : SizedBox(
                        child: AspectRatio(
                          aspectRatio: 1 / 2,
                          child: ListView.builder(
                            itemCount: _atendimentos.length,
                            itemBuilder: (context, index) {
                              final item = _atendimentos[index];
                              return InkWell(
                                onTap: () async {
                                  await _sharedPref.save('protocolo', item.protocolo ?? '');
                                  context.go('/home/atendimento');
                                },
                                child: Card(
                                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Protocolo', style: const TextStyle(fontWeight: FontWeight.bold)),
                                        Text('  ${item.protocolo ?? ''}'),
                                        const SizedBox(height: 4),
                                        Text('Nome', style: const TextStyle(fontWeight: FontWeight.bold)),
                                        Text('  ${item.beneficiarioNome ?? ''}'),
                                        const SizedBox(height: 4),
                                        Text('Dt Solicitação', style: const TextStyle(fontWeight: FontWeight.bold)),
                                        Text('  ${dateFormatter(item.dtSolicitacao ?? '')}'),
                                        const SizedBox(height: 4),
                                        Text('Tipo Atendimento', style: const TextStyle(fontWeight: FontWeight.bold)),
                                        Text('  ${item.tipo?.nome ?? ''}'),
                                        const SizedBox(height: 4),
                                        Text('Responsável', style: const TextStyle(fontWeight: FontWeight.bold)),
                                        Text('  ${item.responsavel?.nome ?? ''}'),
                                        const SizedBox(height: 4),
                                        Text('Status', style: const TextStyle(fontWeight: FontWeight.bold)),
                                        Text('  ${item.status?.nome ?? ''}'),
                                        const SizedBox(height: 4),
                                        Text('Médico Solicitante', style: const TextStyle(fontWeight: FontWeight.bold)),
                                        Text('  ${item.prestadorNome ?? ''}'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    idTipoAtendimentoController.dispose();
    nomeTipoAtendimentoController.dispose();
    idAssuntoController.dispose();
    nomeAssuntoController.dispose();
    idCanalController.dispose();
    nomeCanalController.dispose();
    idCaraterAtendimentoController.dispose();
    nomeCaraterAtendimentoController.dispose();
    idStatusController.dispose();
    nomeStatusController.dispose();
    idMedSolController.dispose();
    nomeMedSolController.dispose();
    idResponsavelController.dispose();
    nomeResponsavelController.dispose();
    idBeneficiarioController.dispose();
    nomeBeneficiarioController.dispose();
    idProtocoloController.dispose();
    nomeProtocoloController.dispose();
    idNomeController.dispose();
    nomeNomeController.dispose();
    idDtSolIniController.dispose();
    nomeDtSolIniController.dispose();
    idDtSolFinController.dispose();
    nomeDtSolFinController.dispose();
    _dadosTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final resStatus = await statusReq.reqListarStatus(true, true, context);
    for (var element in resStatus) {
      if (element.nome == 'ABERTO') {
        statusCarregado = element;
        break;
      }
    }
    final resAtendimento = await atendimentoReq.reqListarAtendimento(AtendimentoSC(status: statusCarregado.id), false, context);
    if (!mounted) return;
    setState(() {
      _atendimentos = resAtendimento;
      _sortLargeScreen<String>((Atendimento d) => d.dtSolicitacao ?? '', 3, _sortAscending);
      idResponsavelController.text = widget.pessoaLogada.usuario?.id ?? '';
      nomeResponsavelController.text = widget.pessoaLogada.usuario?.nome ?? '';
      idStatusController.text = statusCarregado.id ?? '';
      nomeStatusController.text = statusCarregado.nome ?? '';
    });
  }

  void _limparCampos() {
    idTipoAtendimentoController.clear();
    nomeTipoAtendimentoController.clear();
    idAssuntoController.clear();
    nomeAssuntoController.clear();
    idCanalController.clear();
    nomeCanalController.clear();
    idCaraterAtendimentoController.clear();
    nomeCaraterAtendimentoController.clear();
    idStatusController.clear();
    nomeStatusController.clear();
    idMedSolController.clear();
    nomeMedSolController.clear();
    idResponsavelController.text = widget.pessoaLogada.usuario?.id ?? '';
    nomeResponsavelController.text = widget.pessoaLogada.usuario?.nome ?? '';
    idBeneficiarioController.clear();
    nomeBeneficiarioController.clear();
    idProtocoloController.clear();
    nomeProtocoloController.clear();
    idNomeController.clear();
    nomeNomeController.clear();
    idDtSolIniController.clear();
    nomeDtSolIniController.clear();
    idDtSolFinController.clear();
    nomeDtSolFinController.clear();
  }

  void _mostrarBarraCarregamento() {
    setState(() => barraCarregamento = !barraCarregamento);
  }

  void _sortLargeScreen<T>(Comparable<T> Function(Atendimento d) getField, int columnIndex, bool ascending) {
    _atendimentos.sort((Atendimento a, Atendimento b) {
      if (!ascending) {
        final Atendimento c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }
}
