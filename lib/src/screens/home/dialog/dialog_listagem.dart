// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:brasil_fields/brasil_fields.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/pessoa_cadastro.dart';
import 'package:modulohu_web/src/models/user_action.dart';
import 'package:modulohu_web/src/screens/home/dialog/dialog_cadastro_pessoa.dart';
import 'package:modulohu_web/src/services/api/req/beneficiario_req.dart';
import 'package:modulohu_web/src/services/api/req/medico_solicitante_req.dart';
import 'package:modulohu_web/src/services/api/req/pessoa_cadastro_req.dart';
import 'package:modulohu_web/src/services/api/req/procedimentos_req.dart';
import 'package:modulohu_web/src/utils/shared_pref.dart';
import 'package:modulohu_web/src/utils/utils.dart';

class DialogListagem extends StatefulWidget {
  final String title;
  final List<dynamic> list;
  final TextEditingController id;
  final TextEditingController cod;
  final TextEditingController nome;
  final TextEditingController contrato;
  final UserAction pessoaLogada;

  const DialogListagem({
    super.key,
    required this.title,
    required this.list,
    required this.id,
    required this.cod,
    required this.nome,
    required this.contrato,
    required this.pessoaLogada,
  });

  @override
  State<DialogListagem> createState() => _DialogListagemState();
}

class ListDataSource extends DataTableSource {
  final String title;
  final List _list;
  final TextEditingController id;
  final TextEditingController nome;
  final TextEditingController contrato;
  final bool cardio;
  final BuildContext context;

  ListDataSource(this.title, this._list, this.id, this.nome, this.contrato, this.cardio, this.context);

  final _sharedPref = SharedPref();
  Utils utils = Utils();

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
        if (title == 'Médico Solicitante' ||
            title == 'Beneficiário' ||
            ((title == 'Instituição de Origem' ||
                    title == 'Instituição de Referência' ||
                    title == 'Médico Solicitante ' ||
                    title == 'Médico que irá Receber o Paciente') &&
                cardio))
          DataCell(SizedBox(child: Text(utils.cpfCnpjFormatter(item.pessoa.cnp ?? ''), overflow: TextOverflow.ellipsis, maxLines: 2))),
        if (title != 'Médico Solicitante' &&
            title != 'Beneficiário' &&
            ((title == 'Instituição de Origem' ||
                    title == 'Instituição de Referência' ||
                    title == 'Médico Solicitante ' ||
                    title == 'Médico que irá Receber o Paciente') &&
                !cardio))
          DataCell(SizedBox(child: Text(item.codigo.toString(), overflow: TextOverflow.ellipsis, maxLines: 2))),
        if (title != 'Médico Solicitante' &&
            title != 'Beneficiário' &&
            title != 'Instituição de Origem' &&
            title != 'Instituição de Referência' &&
            title != 'Médico Solicitante ' &&
            title != 'Médico que irá Receber o Paciente')
          DataCell(SizedBox(child: Text(item.codigo.toString(), overflow: TextOverflow.ellipsis, maxLines: 2))),
        DataCell(VerticalDivider()),
        if (title == 'Médico Solicitante' ||
            title == 'Beneficiário' ||
            ((title == 'Instituição de Origem' ||
                    title == 'Instituição de Referência' ||
                    title == 'Médico Solicitante ' ||
                    title == 'Médico que irá Receber o Paciente') &&
                cardio))
          DataCell(SizedBox(child: Text(item.pessoa.nome, overflow: TextOverflow.ellipsis, maxLines: 2))),
        if (title != 'Médico Solicitante' &&
            title != 'Beneficiário' &&
            ((title == 'Instituição de Origem' ||
                    title == 'Instituição de Referência' ||
                    title == 'Médico Solicitante ' ||
                    title == 'Médico que irá Receber o Paciente') &&
                !cardio))
          DataCell(SizedBox(child: Text(item.nome, overflow: TextOverflow.ellipsis, maxLines: 2))),
        if (title != 'Médico Solicitante' &&
            title != 'Beneficiário' &&
            title != 'Instituição de Origem' &&
            title != 'Instituição de Referência' &&
            title != 'Médico Solicitante ' &&
            title != 'Médico que irá Receber o Paciente')
          DataCell(SizedBox(child: Text(item.nome, overflow: TextOverflow.ellipsis, maxLines: 2))),
        if (title == 'Tipo de Atendimento') DataCell(VerticalDivider()),
        if (title == 'Tipo de Atendimento') DataCell(SizedBox(child: Text(item.prazo.toString(), overflow: TextOverflow.ellipsis, maxLines: 2))),
        if (title == 'Beneficiário') DataCell(VerticalDivider()),
        if (title == 'Beneficiário') DataCell(SizedBox(child: Text(item.codigo.toString(), overflow: TextOverflow.ellipsis, maxLines: 2))),
        if (title == 'Status') DataCell(VerticalDivider()),
        if (title == 'Status') DataCell(SizedBox(child: Text(item.ativo ? 'SIM' : 'NÃO', overflow: TextOverflow.ellipsis, maxLines: 2))),
        if (title == 'Status') DataCell(VerticalDivider()),
        if (title == 'Status') DataCell(SizedBox(child: Text(item.fixo ? 'SIM' : 'NÃO', overflow: TextOverflow.ellipsis, maxLines: 2))),
      ],
      onSelectChanged: (_) async {
        if (title == 'Médico Solicitante' ||
            ((title == 'Instituição de Origem' ||
                    title == 'Instituição de Referência' ||
                    title == 'Médico Solicitante ' ||
                    title == 'Médico que irá Receber o Paciente') &&
                cardio)) {
          id.text = item.pessoa.autoId.toString();
          nome.text = item.pessoa.nome;
        } else if (title == 'Beneficiário') {
          id.text = item.codigo.toString();
          nome.text = item.pessoa.nome;
          contrato.text = item.contrato.codigo.toString();
        } else if ((title == 'Instituição de Origem' ||
                title == 'Instituição de Referência' ||
                title == 'Médico Solicitante ' ||
                title == 'Médico que irá Receber o Paciente') &&
            !cardio) {
          id.text = item.codigo.toString();
          nome.text = item.nome;
        } else {
          if (title == 'Especialidade') {
            id.text = item.autoId.toString();
          } else if (title == 'Procedimento') {
            id.text = item.codigo.toString();
          } else {
            id.text = item.id.toString();
          }
          nome.text = item.nome;
        }
        if (title == 'Responsável') await _sharedPref.save('responsavel', jsonEncode(item));
        notifyListeners();
        Navigator.of(context).pop();
      },
    );
  }
}

class _DialogListagemState extends State<DialogListagem> {
  final scrollController = ScrollController();
  List<dynamic> filteredList = [];
  final searchController = TextEditingController();
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final nomeFocus = FocusNode();
  final pessoaCadastro = PessoaCadastro();
  var barraCarregamento = false;
  var _ativoValue = true;
  var _cardioValue = true;
  var cardio = true;
  BeneficiarioReq beneficiarioReq = BeneficiarioReq();
  MedicoSolicitanteReq medicoSolicitanteReq = MedicoSolicitanteReq();
  PessoaCadastroReq pessoaCadastroReq = PessoaCadastroReq();
  ProcedimentosReq reqListarProcedimentos = ProcedimentosReq();
  Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    Future<void> consultar() async {
      _mostrarBarraCarregamento();
      if (widget.title == 'Médico Solicitante') {
        final res = await medicoSolicitanteReq.reqListarMedicoSolicitante(nomeController.text, cpfController.text, context);
        setState(() => filteredList = res);
      } else if (widget.title == 'Beneficiário') {
        final res = await beneficiarioReq.reqListarBeneficiario(
          null,
          nomeController.text,
          cpfController.text.replaceAll(RegExp(r'[.\-]'), ''),
          _ativoValue,
          context,
        );
        setState(() => filteredList = res);
      } else if (widget.title == 'Instituição de Origem' ||
          widget.title == 'Instituição de Referência' ||
          widget.title == 'Médico Solicitante ' ||
          widget.title == 'Médico que irá Receber o Paciente') {
        if (_cardioValue) {
          final res = await medicoSolicitanteReq.reqListarMedicoSolicitante(nomeController.text, cpfController.text, context);
          cardio = true;
          setState(() => filteredList = res);
        } else {
          final res = await pessoaCadastroReq.reqListarPessoa(nomeController.text, cpfController.text, true, context);
          cardio = false;
          setState(() => filteredList = res);
        }
      } else {
        final res = await reqListarProcedimentos.reqListarProcedimentos(nomeController.text, context);
        setState(() => filteredList = res);
      }
      nomeController.clear();
      cpfController.clear();
      _mostrarBarraCarregamento();
    }

    return AlertDialog(
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
          color: theme.colorScheme.secondary,
        ),
        padding: EdgeInsets.all(4),
        child: Center(child: Text(widget.title, style: TextStyle(color: theme.colorScheme.onSecondary))),
      ),
      actionsPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(4),
      titlePadding: EdgeInsets.all(0),
      content: SizedBox(
        width: Responsive.isLargeScreen(context) ? size.width * 0.33 : size.width,
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          trackVisibility: true,
          radius: Radius.zero,
          interactive: true,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  if (widget.title == 'Médico Solicitante' ||
                      widget.title == 'Beneficiário' ||
                      widget.title == 'Procedimento' ||
                      widget.title == 'Instituição de Origem' ||
                      widget.title == 'Instituição de Referência' ||
                      widget.title == 'Médico Solicitante ' ||
                      widget.title == 'Médico que irá Receber o Paciente')
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FormTextField(
                            hint: 'Pesquise por um ${widget.title} para iniciar a listagem',
                            margin: const EdgeInsets.all(8),
                            controller: nomeController,
                            enter: () => consultar(),
                            focusNode: nomeFocus,
                            text: 'Nome',
                          ),
                        ),
                        if (widget.title == 'Beneficiário') Checkbox(value: _ativoValue, onChanged: (value) => setState(() => _ativoValue = value!)),
                        if (widget.title == 'Beneficiário')
                          Container(margin: EdgeInsets.only(right: 8), child: Text('Ativo', style: TextStyle(color: theme.colorScheme.onSurface))),
                        if (widget.title == 'Instituição de Origem' ||
                            widget.title == 'Instituição de Referência' ||
                            widget.title == 'Médico Solicitante ' ||
                            widget.title == 'Médico que irá Receber o Paciente')
                          Checkbox(value: _cardioValue, onChanged: (value) => setState(() => _cardioValue = value!)),
                        if (widget.title == 'Instituição de Origem' ||
                            widget.title == 'Instituição de Referência' ||
                            widget.title == 'Médico Solicitante ' ||
                            widget.title == 'Médico que irá Receber o Paciente')
                          Container(margin: EdgeInsets.only(right: 8), child: Text('Cardio', style: TextStyle(color: theme.colorScheme.onSurface))),
                        if (widget.title != 'Beneficiário' &&
                            widget.title != 'Instituição de Origem' &&
                            widget.title != 'Instituição de Referência' &&
                            widget.title != 'Médico Solicitante ' &&
                            widget.title != 'Médico que irá Receber o Paciente')
                          Container(
                            margin: const EdgeInsets.all(8),
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
                  if (widget.title == 'Beneficiário' ||
                      widget.title == 'Instituição de Origem' ||
                      widget.title == 'Instituição de Referência' ||
                      widget.title == 'Médico Solicitante ' ||
                      widget.title == 'Médico que irá Receber o Paciente')
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FormTextField(
                            margin: const EdgeInsets.all(8),
                            inputFormatters: [utils.onlyNumbers, CpfOuCnpjFormatter()],
                            controller: cpfController,
                            text: 'CPF/CNPJ',
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
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
                  if (widget.title != 'Médico Solicitante' &&
                      widget.title != 'Beneficiário' &&
                      widget.title != 'Procedimento' &&
                      widget.title != 'Instituição de Origem' &&
                      widget.title != 'Instituição de Referência' &&
                      widget.title != 'Médico Solicitante ' &&
                      widget.title != 'Médico que irá Receber o Paciente')
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Expanded(child: FormTextField(margin: const EdgeInsets.all(8), controller: searchController, icon: Icons.search, text: ''))],
                    ),
                  if (widget.title == 'Beneficiário' ||
                      widget.title == 'Instituição de Origem' ||
                      widget.title == 'Instituição de Referência' ||
                      widget.title == 'Médico Solicitante ' ||
                      widget.title == 'Médico que irá Receber o Paciente')
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return DialogCadastroPessoa(pessoaCadastro: pessoaCadastro, pessoaLogada: widget.pessoaLogada, title: widget.title);
                              },
                            );
                            if (pessoaCadastro.nome != null && pessoaCadastro.nome != '') {
                              widget.cod.text = pessoaCadastro.cpf ?? '';
                              widget.nome.text = pessoaCadastro.nome ?? '';
                              widget.contrato.text = '';
                              Navigator.pop(context);
                            }
                          },
                          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          buttonColor: Colors.green,
                          text: 'Cadastro',
                        ),
                      ],
                    ),
                  loadingBar(barraCarregamento),
                  Container(
                    decoration: BoxDecoration(color: theme.colorScheme.outline, borderRadius: BorderRadius.circular(4)),
                    margin: EdgeInsets.only(top: 4),
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
                            if (widget.title == 'Médico Solicitante' ||
                                widget.title == 'Beneficiário' ||
                                widget.title == 'Instituição de Origem' ||
                                widget.title == 'Instituição de Referência' ||
                                widget.title == 'Médico Solicitante ' ||
                                widget.title == 'Médico que irá Receber o Paciente')
                              DataColumn(label: Text('CPF/CNPJ')),
                            if (widget.title != 'Médico Solicitante' &&
                                widget.title != 'Beneficiário' &&
                                widget.title != 'Instituição de Origem' &&
                                widget.title != 'Instituição de Referência' &&
                                widget.title != 'Médico Solicitante ' &&
                                widget.title != 'Médico que irá Receber o Paciente')
                              DataColumn(label: Text('Cod')),
                            DataColumn(label: VerticalDivider()),
                            DataColumn(label: Text('Nome')),
                            if (widget.title == 'Tipo de Atendimento') DataColumn(label: VerticalDivider()),
                            if (widget.title == 'Tipo de Atendimento') DataColumn(label: Text('Prazo')),
                            if (widget.title == 'Beneficiário') DataColumn(label: VerticalDivider()),
                            if (widget.title == 'Beneficiário') DataColumn(label: Text('Carteirinha')),
                            if (widget.title == 'Status') DataColumn(label: VerticalDivider()),
                            if (widget.title == 'Status') DataColumn(label: Text('Ativo')),
                            if (widget.title == 'Status') DataColumn(label: VerticalDivider()),
                            if (widget.title == 'Status') DataColumn(label: Text('Fixo')),
                          ],
                          source: ListDataSource(widget.title, filteredList, widget.id, widget.nome, widget.contrato, cardio, context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Button(onPressed: () => Navigator.of(context).pop(), margin: EdgeInsets.all(8), text: 'Fechar', buttonColor: Colors.blueAccent)],
        ),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    nomeController.dispose();
    cpfController.dispose();
    nomeFocus.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    nomeFocus.requestFocus();
    filteredList = widget.list;
    searchController.addListener(_filterList);
  }

  void _filterList() {
    setState(() {
      filteredList =
          widget.list.where((item) {
            return item.nome.toLowerCase().contains(searchController.text.toLowerCase()) || item.codigo.toString().contains(searchController.text);
          }).toList();
    });
  }

  void _mostrarBarraCarregamento() {
    setState(() => barraCarregamento = !barraCarregamento);
  }
}
