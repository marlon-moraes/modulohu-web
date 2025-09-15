// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/cadastros_transferencia_res.dart';
import 'package:modulohu_web/src/models/user_action.dart';
import 'package:modulohu_web/src/screens/home/atendimento/abas/transferencia/dialog/dialog_edicao_cadastro_transferencia.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_cobertura_contratual_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_convenio_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_equipe_transporte_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_meio_transporte_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_motivo_nao_atendida_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_motivo_rejeitado_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_motivo_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_motivo_solicitacao_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_precaucao_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_tipo_internacao_req.dart';
import 'package:modulohu_web/src/utils/shared_pref.dart';

class DialogCadastroTransferencia extends StatefulWidget {
  final String title;
  final List<CadastrosTransferenciaRes> list;
  final UserAction pessoaLogada;
  final TextEditingController nome;

  const DialogCadastroTransferencia({super.key, required this.title, required this.list, required this.pessoaLogada, required this.nome});

  @override
  State<DialogCadastroTransferencia> createState() => _DialogCadastroTransferenciaState();
}

class ListDataSource extends DataTableSource {
  final String title;
  final List<CadastrosTransferenciaRes> _list;
  final UserAction pessoaLogada;
  final Function(dynamic) atualizarListagem;
  final Size size;
  final TextEditingController nome;
  final BuildContext context;

  ListDataSource(this.title, this._list, this.pessoaLogada, this.atualizarListagem, this.size, this.nome, this.context);

  final _sharedPref = SharedPref();

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
            width: Responsive.isLargeScreen(context) ? size.width * 0.15 : null,
            child: Text(item.nome ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          SizedBox(
            width: Responsive.isLargeScreen(context) ? size.width * 0.05 : null,
            child: IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return DialogEdicaoCadastroTransferencia(title: title, isModoInclusao: false, item: item, pessoaLogada: pessoaLogada);
                  },
                );
                if (title == 'Cobertura Contratual') {
                  final res = await reqListarCoberturaContratual(context);
                  atualizarListagem(res);
                } else if (title == 'Convênio') {
                  final res = await reqListarConvenio(context);
                  atualizarListagem(res);
                } else if (title == 'Equipe de Transporte') {
                  final res = await reqListarEquipeTransporte(context);
                  atualizarListagem(res);
                } else if (title == 'Meio de Transporte') {
                  final res = await reqListarMeioTransporte(context);
                  atualizarListagem(res);
                } else if (title == 'Motivo') {
                  final res = await reqListarMotivo(context);
                  atualizarListagem(res);
                } else if (title == 'Motivo não Atendida') {
                  final res = await reqListarMotivoNaoAtendida(context);
                  atualizarListagem(res);
                } else if (title == 'Motivo Rejeitado') {
                  final res = await reqListarMotivoRejeitado(context);
                  atualizarListagem(res);
                } else if (title == 'Motivo Solicitação') {
                  final res = await reqListarMotivoSolicitacao(context);
                  atualizarListagem(res);
                } else if (title == 'Precaução') {
                  final res = await reqListarPrecaucao(context);
                  atualizarListagem(res);
                } else if (title == 'Tipo de Internação') {
                  final res = await reqListarTipoInternacao(context);
                  atualizarListagem(res);
                }
              },
              icon: Icon(Icons.edit),
            ),
          ),
        ),
      ],
      onSelectChanged: (_) async {
        nome.text = item.nome ?? '';
        if (title == 'Cobertura Contratual') {
          await _sharedPref.save('coberturaContratual', jsonEncode(item));
        } else if (title == 'Convênio') {
          await _sharedPref.save('convenio', jsonEncode(item));
        } else if (title == 'Equipe de Transporte') {
          await _sharedPref.save('equipeTransporte', jsonEncode(item));
        } else if (title == 'Meio de Transporte') {
          await _sharedPref.save('meioTransporte', jsonEncode(item));
        } else if (title == 'Motivo') {
          await _sharedPref.save('motivo', jsonEncode(item));
        } else if (title == 'Motivo não Atendida') {
          await _sharedPref.save('motivoNaoAtendida', jsonEncode(item));
        } else if (title == 'Motivo Rejeitado') {
          await _sharedPref.save('motivoRejeitado', jsonEncode(item));
        } else if (title == 'Motivo Solicitação') {
          await _sharedPref.save('motivoSolicitacao', jsonEncode(item));
        } else if (title == 'Precaução') {
          await _sharedPref.save('precaucao', jsonEncode(item));
        } else if (title == 'Tipo de Internação') {
          await _sharedPref.save('tipoInternacao', jsonEncode(item));
        }
        notifyListeners();
        Navigator.pop(context);
      },
    );
  }
}

class _DialogCadastroTransferenciaState extends State<DialogCadastroTransferencia> {
  final scrollController = ScrollController();
  final searchController = TextEditingController();
  List<CadastrosTransferenciaRes> filteredList = [];

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
                                return DialogEdicaoCadastroTransferencia(
                                  title: widget.title,
                                  isModoInclusao: true,
                                  item: CadastrosTransferenciaRes(),
                                  pessoaLogada: widget.pessoaLogada,
                                );
                              },
                            );
                            if (widget.title == 'Cobertura Contratual') {
                              final res = await reqListarCoberturaContratual(context);
                              setState(() => filteredList = res);
                            } else if (widget.title == 'Convênio') {
                              final res = await reqListarConvenio(context);
                              setState(() => filteredList = res);
                            } else if (widget.title == 'Equipe de Transporte') {
                              final res = await reqListarEquipeTransporte(context);
                              setState(() => filteredList = res);
                            } else if (widget.title == 'Meio de Transporte') {
                              final res = await reqListarMeioTransporte(context);
                              setState(() => filteredList = res);
                            } else if (widget.title == 'Motivo') {
                              final res = await reqListarMotivo(context);
                              setState(() => filteredList = res);
                            } else if (widget.title == 'Motivo não Atendida') {
                              final res = await reqListarMotivoNaoAtendida(context);
                              setState(() => filteredList = res);
                            } else if (widget.title == 'Motivo Rejeitado') {
                              final res = await reqListarMotivoRejeitado(context);
                              setState(() => filteredList = res);
                            } else if (widget.title == 'Motivo Solicitação') {
                              final res = await reqListarMotivoSolicitacao(context);
                              setState(() => filteredList = res);
                            } else if (widget.title == 'Precaução') {
                              final res = await reqListarPrecaucao(context);
                              setState(() => filteredList = res);
                            } else if (widget.title == 'Tipo de Internação') {
                              final res = await reqListarTipoInternacao(context);
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
                            DataColumn(label: VerticalDivider()),
                            DataColumn(label: Expanded(child: Center(child: Text('')))),
                          ],
                          source: ListDataSource(widget.title, filteredList, widget.pessoaLogada, _atualizarListagem, size, widget.nome, context),
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
    filteredList = List.from(widget.list)..sort((a, b) => a.codigo!.compareTo(b.codigo!));
    searchController.addListener(_filterList);
  }

  void _atualizarListagem(dynamic list) {
    setState(() => filteredList = list);
  }

  void _filterList() {
    setState(() {
      filteredList =
          widget.list.where((item) {
            return item.nome!.toLowerCase().contains(searchController.text.toLowerCase()) || item.codigo.toString().contains(searchController.text);
          }).toList();
    });
  }
}
