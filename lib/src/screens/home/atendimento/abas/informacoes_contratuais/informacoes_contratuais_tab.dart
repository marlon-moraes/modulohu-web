// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/cobertura.dart';
import 'package:modulohu_web/src/models/contrato.dart';
import 'package:modulohu_web/src/models/modulo_beneficiario.dart';
import 'package:modulohu_web/src/services/api/req/contrato_req.dart';
import 'package:modulohu_web/src/utils/cpf_cnpj_formatter.dart';

class InformacoesContratuaisTab extends StatefulWidget {
  final String carteirinha;
  final String contrato;

  const InformacoesContratuaisTab({super.key, required this.carteirinha, required this.contrato});

  @override
  State<InformacoesContratuaisTab> createState() => _InformacoesContratuaisTabState();
}

class ModulosDependentesDataSource extends DataTableSource {
  final List<ModuloBeneficiario> _list;
  final Size size;
  final BuildContext context;

  ModulosDependentesDataSource(this._list, this.size, this.context);

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
            message: item.modulo,
            child: SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.1 : null,
              child: Text(item.modulo ?? '', overflow: TextOverflow.clip, maxLines: 2),
            ),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          Tooltip(
            message: item.nome,
            child: SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.1 : size.width * 0.3,
              child: Text(item.nome ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
            ),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          Tooltip(
            message: item.tipo,
            child: SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.1 : null,
              child: Text(item.tipo ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
            ),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          Tooltip(
            message: dateFormatter(item.dtInicioVigencia ?? ''),
            child: SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.1 : null,
              child: Text(dateFormatter(item.dtInicioVigencia ?? ''), overflow: TextOverflow.ellipsis, maxLines: 2),
            ),
          ),
        ),
      ],
      onSelectChanged: (_) {},
    );
  }
}

class CoberturasDataSource extends DataTableSource {
  final List<Cobertura> _list;
  final Size size;
  final BuildContext context;

  CoberturasDataSource(this._list, this.size, this.context);

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
            message: item.nomeCobertura,
            child: SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.1 : null,
              child: Text(item.nomeCobertura ?? '', overflow: TextOverflow.clip, maxLines: 2),
            ),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          Tooltip(
            message: item.prioridade.toString(),
            child: SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.1 : null,
              child: Text(item.prioridade?.toString() ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
            ),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          Tooltip(
            message: item.carencia,
            child: SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.1 : null,
              child: Text(item.carencia ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
            ),
          ),
        ),
        DataCell(VerticalDivider()),
        DataCell(
          Tooltip(
            message: item.carenciaBeneficiario,
            child: SizedBox(
              width: Responsive.isLargeScreen(context) ? size.width * 0.1 : null,
              child: Text(item.carenciaBeneficiario ?? '', overflow: TextOverflow.ellipsis, maxLines: 2),
            ),
          ),
        ),
      ],
      onSelectChanged: (_) {},
    );
  }
}

class _InformacoesContratuaisTabState extends State<InformacoesContratuaisTab> {
  var _contrato = Contrato();
  List<Cobertura> _coberturas = [];
  List<ModuloBeneficiario> _modulosBeneficiario = [];
  var codContratoController = TextEditingController();
  var codPessoaCardioController = TextEditingController();
  var statusController = TextEditingController();
  var linhaController = TextEditingController();
  var codModuloController = TextEditingController();
  var nomeContaController = TextEditingController();
  var cpfCnpjController = TextEditingController();
  var abrangenciaController = TextEditingController();
  var tipoContratoController = TextEditingController();
  var nomeModuloController = TextEditingController();
  var nomePlanoController = TextEditingController();
  var modeloContratoController = TextEditingController();
  var segmentacaoController = TextEditingController();
  var codPlanoController = TextEditingController();
  var iniVigContratoController = TextEditingController();
  var iniVigBeneficiarioController = TextEditingController();
  var dataBaseCoberturaController = TextEditingController();

  Widget codContrato() {
    return FormTextField(
      controller: codContratoController,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      text: 'Código Contrato',
      enabled: false,
    );
  }

  Widget codPessoaCardio() {
    return FormTextField(
      controller: codPessoaCardioController,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      text: 'Cod Pessoa Cardio',
      enabled: false,
    );
  }

  Widget status() {
    return FormTextField(
      controller: statusController,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      text: 'Status',
      enabled: false,
    );
  }

  Widget linha() {
    return FormTextField(controller: linhaController, margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), text: 'Linha', enabled: false);
  }

  Widget codModulo() {
    return FormTextField(
      controller: codModuloController,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      text: 'Código Módulo',
      enabled: false,
    );
  }

  Widget nomeConta() {
    return FormTextField(
      controller: nomeContaController,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      text: 'Nome Conta',
      enabled: false,
    );
  }

  Widget cpfCnpj() {
    return FormTextField(
      controller: cpfCnpjController,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      text: 'CPF/CNPJ',
      enabled: false,
    );
  }

  Widget abrangencia() {
    return FormTextField(
      controller: abrangenciaController,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      text: 'Abrangência',
      enabled: false,
    );
  }

  Widget tipoContrato() {
    return FormTextField(
      controller: tipoContratoController,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      text: 'Tipo de Contrato',
      enabled: false,
    );
  }

  Widget nomeModulo() {
    return FormTextField(
      controller: nomeModuloController,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      text: 'Nome Módulo',
      enabled: false,
    );
  }

  Widget nomePlano() {
    return FormTextField(
      controller: nomePlanoController,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      text: 'Nome Plano',
      enabled: false,
    );
  }

  Widget modeloContrato() {
    return FormTextField(
      controller: modeloContratoController,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      text: 'Modelo Contrato',
      enabled: false,
    );
  }

  Widget segmentacao() {
    return FormTextField(
      controller: segmentacaoController,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      text: 'Segmentação',
      enabled: false,
    );
  }

  Widget codPlano() {
    return FormTextField(
      controller: codPlanoController,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      text: 'Código Plano',
      enabled: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    Widget iniVigContrato() {
      return Row(
        children: [
          Expanded(
            child: FormTextField(
              controller: iniVigContratoController,
              inputFormatters: [mascaraDataHora],
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              text: 'Ini. Vig. Contrato',
              enabled: true,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () {},
              child: Ink(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.grey),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget iniVigBeneficiario() {
      return Row(
        children: [
          Expanded(
            child: FormTextField(
              controller: iniVigBeneficiarioController,
              inputFormatters: [mascaraDataHora],
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              text: 'Ini. Vig. Beneficiário',
              enabled: true,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () {},
              child: Ink(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.grey),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget dataBaseCobertura() {
      return Row(
        children: [
          Expanded(
            child: FormTextField(
              controller: dataBaseCoberturaController,
              inputFormatters: [mascaraDataHora],
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              text: 'Data Base Cobertura',
              enabled: true,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () {},
              child: Ink(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.grey),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    List<Widget> tables() {
      return [
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: theme.colorScheme.outline, borderRadius: BorderRadius.circular(4)),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                PaginatedDataTable(
                  header: Text('Módulos Dependentes', style: TextStyle(fontWeight: FontWeight.bold)),
                  showFirstLastButtons: true,
                  showCheckboxColumn: false,
                  horizontalMargin: 10,
                  columnSpacing: 10,
                  rowsPerPage: 4,
                  columns: [
                    DataColumn(label: Expanded(child: Center(child: Text('Módulo')))),
                    DataColumn(label: VerticalDivider()),
                    DataColumn(label: Expanded(child: Center(child: Text('Nome')))),
                    DataColumn(label: VerticalDivider()),
                    DataColumn(label: Expanded(child: Center(child: Text('Tipo')))),
                    DataColumn(label: VerticalDivider()),
                    DataColumn(label: Expanded(child: Center(child: Text('Inicio Vig.')))),
                  ],
                  source: ModulosDependentesDataSource(_modulosBeneficiario, size, context),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: theme.colorScheme.outline, borderRadius: BorderRadius.circular(4)),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                PaginatedDataTable(
                  header: Text('Coberturas', style: TextStyle(fontWeight: FontWeight.bold)),
                  showFirstLastButtons: true,
                  showCheckboxColumn: false,
                  horizontalMargin: 10,
                  columnSpacing: 10,
                  rowsPerPage: 4,
                  columns: [
                    DataColumn(label: Expanded(child: Center(child: Text('Nome')))),
                    DataColumn(label: VerticalDivider()),
                    DataColumn(label: Expanded(child: Center(child: Text('Prioridade')))),
                    DataColumn(label: VerticalDivider()),
                    DataColumn(label: Expanded(child: Center(child: Text('Carência')))),
                    DataColumn(label: VerticalDivider()),
                    DataColumn(label: Expanded(child: Center(child: Text('Carência Beneficiário')))),
                  ],
                  source: CoberturasDataSource(_coberturas, size, context),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    return Column(
      children: [
        SizedBox(height: 4),
        if (Responsive.isLargeScreen(context))
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(children: [Expanded(child: codContrato())]),
                        Row(children: [Expanded(child: codPessoaCardio())]),
                        Row(children: [Expanded(child: status())]),
                        Row(children: [Expanded(child: linha())]),
                        Row(children: [Expanded(child: codModulo())]),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(children: [Expanded(child: nomeConta())]),
                        Row(children: [Expanded(child: cpfCnpj())]),
                        Row(children: [Expanded(child: abrangencia())]),
                        Row(children: [Expanded(child: tipoContrato())]),
                        Row(children: [Expanded(child: nomeModulo())]),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(children: [Expanded(child: nomePlano())]),
                        Row(children: [Expanded(child: modeloContrato())]),
                        Row(children: [Expanded(child: segmentacao())]),
                        Row(children: [Expanded(child: codPlano())]),
                      ],
                    ),
                  ),
                ],
              ),
              Row(children: [Expanded(child: iniVigContrato()), Expanded(child: iniVigBeneficiario()), Expanded(child: dataBaseCobertura())]),
            ],
          ),
        if (!Responsive.isLargeScreen(context))
          Column(
            children: [
              codContrato(),
              codPessoaCardio(),
              status(),
              linha(),
              codModulo(),
              nomeConta(),
              cpfCnpj(),
              abrangencia(),
              tipoContrato(),
              nomeModulo(),
              nomePlano(),
              modeloContrato(),
              segmentacao(),
              codPlano(),
              iniVigContrato(),
              iniVigBeneficiario(),
              dataBaseCobertura(),
            ],
          ),
        if (Responsive.isLargeScreen(context)) Row(children: tables()),
        if (!Responsive.isLargeScreen(context)) Expanded(child: Column(children: tables())),
      ],
    );
  }

  @override
  void dispose() {
    codContratoController.dispose();
    codPessoaCardioController.dispose();
    statusController.dispose();
    linhaController.dispose();
    codModuloController.dispose();
    nomeContaController.dispose();
    cpfCnpjController.dispose();
    abrangenciaController.dispose();
    tipoContratoController.dispose();
    nomeModuloController.dispose();
    nomePlanoController.dispose();
    modeloContratoController.dispose();
    segmentacaoController.dispose();
    codPlanoController.dispose();
    iniVigContratoController.dispose();
    iniVigBeneficiarioController.dispose();
    dataBaseCoberturaController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    var resInfoContrato = await reqListarInformacoesContrato(widget.contrato, context);
    if (!mounted) return;
    setState(() => _contrato = resInfoContrato);
    var resInfoCoberturas = await reqListarCoberturas(int.parse(widget.contrato), int.parse(widget.carteirinha), context);
    if (!mounted) return;
    setState(() => _coberturas = resInfoCoberturas);
    var resInfoModulosBeneficiarios = await reqListarModulosBeneficiario(widget.carteirinha, context);
    if (!mounted) return;
    setState(() => _modulosBeneficiario = resInfoModulosBeneficiarios);
    setState(() {
      codContratoController.text = _contrato.codigoContrato?.toString() ?? '';
      codPessoaCardioController.text = _contrato.codPessoaCardioConta ?? '';
      statusController.text = _contrato.status ?? '';
      linhaController.text = _contrato.linhaModuloOperadora ?? '';
      codModuloController.text = _contrato.codModuloOperadora ?? '';
      nomeContaController.text = _contrato.nomeContratante ?? '';
      cpfCnpjController.text = cpfCnpjFormatter(_contrato.cpfCnpjContratante ?? '');
      abrangenciaController.text = _contrato.abrangencia ?? '';
      tipoContratoController.text = _contrato.tipoContratacao ?? '';
      nomeModuloController.text = _contrato.nomeModuloOperadora ?? '';
      nomePlanoController.text = _contrato.nomeClasse ?? '';
      modeloContratoController.text = _contrato.modeloContrato ?? '';
      segmentacaoController.text = _contrato.segmentacao ?? '';
      codPlanoController.text = _contrato.codClasse ?? '';
      iniVigContratoController.text = dateFormatter(_contrato.inicioVigencia ?? '');
    });
  }
}
