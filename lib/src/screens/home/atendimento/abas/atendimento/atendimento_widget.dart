// ignore_for_file: use_build_context_synchronously, must_be_immutable

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:components/components.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/models/evento.dart';

class AssentamentosDataSource extends DataTableSource {
  final List<Evento> _list;
  final TextEditingController tituloController;
  final TextEditingController descricaoController;
  final Evento eventoCarregado;
  final bool barraCarregamento;
  final VoidCallback mostrarBarraCarregamento;
  final VoidCallback limparCamposEventos;
  final VoidCallback alterarModoInclusao;
  final VoidCallback alterarModoAlteracao;
  final Size size;
  final BuildContext context;

  AssentamentosDataSource(
    this._list,
    this.tituloController,
    this.descricaoController,
    this.eventoCarregado,
    this.barraCarregamento,
    this.mostrarBarraCarregamento,
    this.limparCamposEventos,
    this.alterarModoInclusao,
    this.alterarModoAlteracao,
    this.size,
    this.context,
  );

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
          Tooltip(
            message: item.titulo,
            child: SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.1 : null,
              child: Text(item.titulo ?? '', overflow: TextOverflow.clip, maxLines: 2),
            ),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          Tooltip(
            message: item.descricao,
            child: SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.2 : size.width * 0.3,
              child: Text(item.descricao ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
            ),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          Tooltip(
            message: item.usuario,
            child: SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.1 : null,
              child: Text(item.usuario ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
            ),
          ),
        ),
      ],
      onSelectChanged: (_) {
        tituloController.text = item.titulo ?? '';
        descricaoController.text = item.descricao ?? '';
        eventoCarregado.id = item.id;
        eventoCarregado.codigo = item.codigo;
        eventoCarregado.dtInc = item.dtInc;
        eventoCarregado.dtAlt = item.dtAlt;
        alterarModoAlteracao();
      },
    );
  }
}
