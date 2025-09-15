// ignore_for_file: use_build_context_synchronously

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/assunto.dart';
import 'package:modulohu_web/src/models/status.dart';
import 'package:modulohu_web/src/models/tipo_atendimento.dart';
import 'package:modulohu_web/src/models/user_action.dart';
import 'package:modulohu_web/src/screens/home/dialog/dialog_edicao_cadastro.dart';
import 'package:modulohu_web/src/services/api/req/assunto_req.dart';
import 'package:modulohu_web/src/services/api/req/canal_req.dart';
import 'package:modulohu_web/src/services/api/req/carater_atendimento_req.dart';
import 'package:modulohu_web/src/services/api/req/status_req.dart';
import 'package:modulohu_web/src/services/api/req/tipo_atendimento_req.dart';

class DialogCadastro extends StatefulWidget {
  final String title;
  final List<dynamic> list;
  final UserAction pessoaLogada;

  const DialogCadastro({super.key, required this.title, required this.list, required this.pessoaLogada});

  @override
  State<DialogCadastro> createState() => _DialogCadastroState();
}

class ListDataSource extends DataTableSource {
  final String title;
  final List _list;
  final UserAction pessoaLogada;
  final Function(dynamic) atualizarListagem;
  final Size size;
  final BuildContext context;

  ListDataSource(this.title, this._list, this.pessoaLogada, this.atualizarListagem, this.size, this.context);

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
            width: Responsive.isLargeScreen(context) ? size.width * 0.05 : null,
            child: Text(item.codigo.toString(), overflow: TextOverflow.ellipsis, maxLines: 2),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          SizedBox(
            width:
                Responsive.isLargeScreen(context)
                    ? title == 'Tipo de Atendimento'
                        ? size.width * 0.15
                        : title == 'Status'
                        ? size.width * 0.09
                        : size.width * 0.23
                    : null,
            child: Text(item.nome, overflow: TextOverflow.ellipsis, maxLines: 2),
          ),
        ),
        if (title == 'Tipo de Atendimento') DataCell(VerticalDivider()),
        if (title == 'Tipo de Atendimento')
          DataCell(
            SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.05 : null,
              child: Text(item.prazo.toString(), overflow: TextOverflow.ellipsis, maxLines: 2),
            ),
          ),
        if (title == 'Status') DataCell(VerticalDivider()),
        if (title == 'Status')
          DataCell(
            SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.05 : null,
              child: Text(item.ativo ? 'SIM' : 'NÃO', overflow: TextOverflow.ellipsis, maxLines: 2),
            ),
          ),
        if (title == 'Status') DataCell(VerticalDivider()),
        if (title == 'Status')
          DataCell(
            SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.05 : null,
              child: Text(item.fixo ? 'SIM' : 'NÃO', overflow: TextOverflow.ellipsis, maxLines: 2),
            ),
          ),
      ],
      onSelectChanged: (_) async {
        await showDialog(
          context: context,
          builder: (context) {
            return DialogEdicaoCadastro(title: title, isModoInclusao: false, item: item, pessoaLogada: pessoaLogada);
          },
        );
        if (title == 'Tipo de Atendimento') {
          final res = await reqListarTipoAtendimento(context);
          atualizarListagem(res);
        } else if (title == 'Assunto') {
          final res = await reqListarAssunto(context);
          atualizarListagem(res);
        } else if (title == 'Canal') {
          final res = await reqListarCanal(context);
          atualizarListagem(res);
        } else if (title == 'Caráter de Atendimento') {
          final res = await reqListarCaraterAtendimento(context);
          atualizarListagem(res);
        } else if (title == 'Status') {
          final res = await reqListarStatus(true, false, context);
          atualizarListagem(res);
        }
      },
    );
  }
}

class _DialogCadastroState extends State<DialogCadastro> {
  final scrollController = ScrollController();
  final searchController = TextEditingController();
  List<dynamic> filteredList = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: FormTextField(margin: const EdgeInsets.all(8), controller: searchController, icon: Icons.search, text: '')),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return DialogEdicaoCadastro(
                                  title: widget.title,
                                  isModoInclusao: true,
                                  item:
                                      widget.title == 'Tipo de Atendimento'
                                          ? TipoAtendimento()
                                          : widget.title == 'Status'
                                          ? Status()
                                          : Assunto(),
                                  pessoaLogada: widget.pessoaLogada,
                                );
                              },
                            );
                            if (widget.title == 'Tipo de Atendimento') {
                              final res = await reqListarTipoAtendimento(context);
                              setState(() => filteredList = res);
                            } else if (widget.title == 'Assunto') {
                              final res = await reqListarAssunto(context);
                              setState(() => filteredList = res);
                            } else if (widget.title == 'Canal') {
                              final res = await reqListarCanal(context);
                              setState(() => filteredList = res);
                            } else if (widget.title == 'Caráter de Atendimento') {
                              final res = await reqListarCaraterAtendimento(context);
                              setState(() => filteredList = res);
                            } else if (widget.title == 'Status') {
                              final res = await reqListarStatus(true, false, context);
                              setState(() => filteredList = res);
                            }
                          },
                          child: Ink(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: theme.colorScheme.secondary),
                            child: Icon(Icons.add, color: theme.colorScheme.onSecondary),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(color: theme.colorScheme.outline, borderRadius: BorderRadius.circular(4)),
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
                            DataColumn(label: Expanded(child: Center(child: Text('Cod')))),
                            DataColumn(label: VerticalDivider()),
                            DataColumn(label: Expanded(child: Center(child: Text('Nome')))),
                            if (widget.title == 'Tipo de Atendimento') DataColumn(label: VerticalDivider()),
                            if (widget.title == 'Tipo de Atendimento') DataColumn(label: Expanded(child: Center(child: Text('Prazo')))),
                            if (widget.title == 'Status') DataColumn(label: VerticalDivider()),
                            if (widget.title == 'Status') DataColumn(label: Expanded(child: Center(child: Text('Ativo')))),
                            if (widget.title == 'Status') DataColumn(label: VerticalDivider()),
                            if (widget.title == 'Status') DataColumn(label: Expanded(child: Center(child: Text('Fixo')))),
                          ],
                          source: ListDataSource(widget.title, filteredList, widget.pessoaLogada, _atualizarListagem, size, context),
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
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    filteredList = widget.list;
    searchController.addListener(_filterList);
  }

  void _atualizarListagem(dynamic list) {
    setState(() => filteredList = list);
  }

  void _filterList() {
    setState(() {
      filteredList =
          widget.list.where((item) {
            return item.nome.toLowerCase().contains(searchController.text.toLowerCase()) || item.codigo.toString().contains(searchController.text);
          }).toList();
    });
  }
}
