// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/anexo.dart';
import 'package:modulohu_web/src/models/atendimento.dart';
import 'package:modulohu_web/src/models/crud_anexo.dart';
import 'package:modulohu_web/src/models/user_action.dart';
import 'package:modulohu_web/src/services/api/req/anexo_req.dart';

class AnexosTab extends StatefulWidget {
  final UserAction pessoaLogada;
  final Atendimento atendimentoCarregado;
  final bool isModoInclusao;
  final bool isCanceladoFinalizado;

  const AnexosTab({
    super.key,
    required this.pessoaLogada,
    required this.atendimentoCarregado,
    required this.isModoInclusao,
    required this.isCanceladoFinalizado,
  });

  @override
  State<AnexosTab> createState() => _AnexosTabState();
}

class AnexosDataSource extends DataTableSource {
  final List<Anexo> _list;
  final TextEditingController arquivo;
  final TextEditingController descricao;
  final TextEditingController idAnexo;
  final Size size;
  final VoidCallback alterarModo;
  final BuildContext context;

  AnexosDataSource(this._list, this.arquivo, this.descricao, this.idAnexo, this.size, this.alterarModo, this.context);

  AnexoReq anexoReq = AnexoReq();

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
            message: 'Selecionar Anexo',
            child: SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.1 : null,
              child: Text(dateFormatter(item.dtInc ?? ''), overflow: TextOverflow.ellipsis, maxLines: 2),
            ),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          Tooltip(
            message: item.descricao,
            child: SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.3 : size.width * 0.5,
              child: Text(item.descricao ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
            ),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          Tooltip(
            message: item.arquivo,
            child: SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.15 : size.width * 0.25,
              child: Text(item.arquivo ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
            ),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          Tooltip(
            message: 'Selecionar Anexo',
            child: SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.1 : null,
              child: Text(item.idUsuAlt ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
            ),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          Tooltip(
            message: 'Carregar Anexo',
            child: SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.05 : null,
              child: IconButton(onPressed: () => anexoReq.reqCarregarAnexo(item.id ?? '', context), icon: Icon(Icons.open_in_browser_rounded)),
            ),
          ),
        ),
      ],
      onSelectChanged: (_) {
        arquivo.text = item.arquivo ?? '';
        descricao.text = item.descricao ?? '';
        idAnexo.text = item.id ?? '';
        alterarModo();
        notifyListeners();
      },
    );
  }
}

class _AnexosTabState extends State<AnexosTab> {
  final deviceInfo = DeviceInfoPlugin();
  final arquivoController = TextEditingController();
  final descricaoController = TextEditingController();
  final codUsuarioController = TextEditingController();
  final nomeUsuarioController = TextEditingController();
  final idAnexoController = TextEditingController();
  var modoInclusao = true;
  var barraCarregamento = false;
  var _anexos = <Anexo>[];
  var anexo = CRUDAnexo(anexoAtdCRABody: Anexo());
  AnexoReq anexoReq = AnexoReq();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    Future<void> selecionarArquivo() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        anexo.arqBase64 = base64Encode(result.files.first.bytes!.toList());
        arquivoController.text = result.files.first.name;
        anexo.anexoAtdCRABody?.caminho = 'Não foi possível encontrar o caminho do arquivo';
        anexo.anexoAtdCRABody?.arquivo = result.files.first.name;
      }
    }

    Future<void> incluirAnexo() async {
      if (!barraCarregamento) {
        _mostrarBarraCarregamento();
        WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
        anexo.anexoAtdCRABody?.idEmp = widget.pessoaLogada.usuario?.empresa?.id;
        anexo.anexoAtdCRABody?.idUni = widget.pessoaLogada.unidades?.first.idUni;
        anexo.anexoAtdCRABody?.idAtendimentoCRA = widget.atendimentoCarregado.id;
        anexo.anexoAtdCRABody?.idTipoCRA = widget.atendimentoCarregado.tipo?.id;
        anexo.anexoAtdCRABody?.maquina = webBrowserInfo.userAgent;
        anexo.anexoAtdCRABody?.descricao =
            descricaoController.text.isEmpty
                ? 'Anexo do arquivo ${arquivoController.text} para o Atendimento n° ${widget.atendimentoCarregado.codigo}'
                : descricaoController.text;
        anexo.anexoAtdCRABody?.idImagem = 0;
        anexo.anexoAtdCRABody?.idUsuInc = widget.pessoaLogada.usuario?.id;
        anexo.anexoAtdCRABody?.idUsuAlt = widget.pessoaLogada.usuario?.id;
        await anexoReq.reqIncluirAnexo(anexo, context);
        _recarregarAnexos();
        _limparCampos();
        _mostrarBarraCarregamento();
      }
    }

    Future<void> excluirAnexo() async {
      if (!barraCarregamento) {
        _mostrarBarraCarregamento();
        await anexoReq.reqExcluirAnexo(idAnexoController.text, widget.pessoaLogada.usuario?.id ?? '', context);
        _recarregarAnexos();
        _limparCampos();
        _mostrarBarraCarregamento();
      }
    }

    Widget arquivo() {
      return Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FormTextField(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                controller: arquivoController,
                text: 'Arquivo',
                enabled: false,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
              child: InkWell(
                onTap: () => !widget.isModoInclusao && !widget.isCanceladoFinalizado ? selecionarArquivo() : null,
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: !widget.isModoInclusao && !widget.isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey,
                  ),
                  child: Icon(Icons.more_horiz_rounded, color: theme.colorScheme.onPrimary),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget descricao() {
      return Expanded(
        child: FormTextField(margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), controller: descricaoController, text: 'Descrição', enabled: true),
      );
    }

    Widget usuario() {
      return Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: FormTextField(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                controller: codUsuarioController,
                enabled: false,
                hint: 'Cod',
                text: '',
              ),
            ),
            Expanded(
              flex: 8,
              child: FormTextField(margin: const EdgeInsets.fromLTRB(0, 4, 8, 4), controller: nomeUsuarioController, text: 'Usuário', enabled: false),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
              child: InkWell(
                child: Ink(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.grey),
                  child: Icon(Icons.more_horiz_rounded, color: theme.colorScheme.onPrimary),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          width: Responsive.isLargeScreen(context) ? size.width * 0.8 : null,
          child: Column(
            children: [
              SizedBox(height: 2),
              if (Responsive.isLargeScreen(context)) Row(crossAxisAlignment: CrossAxisAlignment.center, children: [arquivo(), descricao(), usuario()]),
              if (!Responsive.isLargeScreen(context))
                Column(
                  children: [
                    Row(children: [arquivo()]),
                    Row(children: [descricao()]),
                    Row(children: [usuario()]),
                  ],
                ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(color: theme.colorScheme.outline, borderRadius: BorderRadius.circular(4)),
          width: Responsive.isLargeScreen(context) ? size.width * 0.8 : null,
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              PaginatedDataTable(
                showFirstLastButtons: true,
                showCheckboxColumn: false,
                horizontalMargin: 5,
                columnSpacing: 5,
                rowsPerPage: 4,
                columns: [
                  DataColumn(label: Expanded(child: Center(child: Text('Data', overflow: TextOverflow.clip, maxLines: 2)))),
                  DataColumn(label: VerticalDivider()),
                  DataColumn(label: Expanded(child: Center(child: Text('Descrição', overflow: TextOverflow.clip, maxLines: 2)))),
                  DataColumn(label: VerticalDivider()),
                  DataColumn(label: Expanded(child: Center(child: Text('Arquivo', overflow: TextOverflow.clip, maxLines: 2)))),
                  DataColumn(label: VerticalDivider()),
                  DataColumn(label: Expanded(child: Center(child: Text('Usuário', overflow: TextOverflow.clip, maxLines: 2)))),
                  DataColumn(label: VerticalDivider()),
                  DataColumn(label: Expanded(child: Center(child: Text('', overflow: TextOverflow.clip, maxLines: 2)))),
                ],
                source: AnexosDataSource(_anexos, arquivoController, descricaoController, idAnexoController, size, _alterarModo, context),
              ),
            ],
          ),
        ),
        loadingBar(barraCarregamento),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (modoInclusao)
              Button(
                buttonColor: !widget.isModoInclusao && !widget.isCanceladoFinalizado ? Colors.blueAccent : Colors.grey,
                onPressed: () => !widget.isModoInclusao && !widget.isCanceladoFinalizado ? incluirAnexo() : null,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                contentColor: theme.colorScheme.surface,
                text: 'Incluir',
              ),
            if (!modoInclusao)
              Button(
                buttonColor: !widget.isModoInclusao && !widget.isCanceladoFinalizado ? Colors.red : Colors.grey,
                onPressed: () => !widget.isModoInclusao && !widget.isCanceladoFinalizado ? excluirAnexo() : null,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                contentColor: theme.colorScheme.surface,
                text: 'Excluir',
              ),
            Button(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              contentColor: theme.colorScheme.surface,
              buttonColor: Colors.brown,
              onPressed: () => _limparCampos(),
              text: 'Limpar',
            ),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    codUsuarioController.text = widget.pessoaLogada.usuario?.codigo.toString() ?? '';
    nomeUsuarioController.text = widget.pessoaLogada.usuario?.nome ?? '';
    _carregarAnexos();
  }

  Future<void> _carregarAnexos() async {
    if (widget.atendimentoCarregado.id != null) {
      var res = await anexoReq.reqListarAnexo(widget.atendimentoCarregado.id ?? '', context);
      if (mounted) setState(() => _anexos = res);
    }
  }

  void _alterarModo() {
    setState(() => modoInclusao = false);
  }

  Future<void> _recarregarAnexos() async {
    var resAnexos = await anexoReq.reqListarAnexo(widget.atendimentoCarregado.id ?? '', context);
    if (mounted) setState(() => _anexos = resAnexos);
  }

  void _limparCampos() {
    arquivoController.clear();
    descricaoController.clear();
    idAnexoController.clear();
    setState(() => modoInclusao = true);
  }

  void _mostrarBarraCarregamento() {
    setState(() => barraCarregamento = !barraCarregamento);
  }
}
