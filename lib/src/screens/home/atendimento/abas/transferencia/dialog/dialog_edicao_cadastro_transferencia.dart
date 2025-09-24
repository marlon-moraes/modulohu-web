// ignore_for_file: use_build_context_synchronously

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:components/components.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/crud_cadastro.dart';
import 'package:modulohu_web/src/models/user_action.dart';
import 'package:modulohu_web/src/services/api/req/cobertura_contratual_req.dart';
import 'package:modulohu_web/src/services/api/req/convenio_req.dart';
import 'package:modulohu_web/src/services/api/req/equipe_transporte_req.dart';
import 'package:modulohu_web/src/services/api/req/meio_transporte_req.dart';
import 'package:modulohu_web/src/services/api/req/motivo_nao_atendida_req.dart';
import 'package:modulohu_web/src/services/api/req/motivo_rejeitado_req.dart';
import 'package:modulohu_web/src/services/api/req/motivo_req.dart';
import 'package:modulohu_web/src/services/api/req/motivo_solicitacao_req.dart';
import 'package:modulohu_web/src/services/api/req/precaucao_req.dart';
import 'package:modulohu_web/src/services/api/req/tipo_internacao_req.dart';
import 'package:modulohu_web/src/utils/utils.dart';

class DialogEdicaoCadastroTransferencia extends StatefulWidget {
  final String title;
  final bool isModoInclusao;
  final dynamic item;
  final UserAction pessoaLogada;

  const DialogEdicaoCadastroTransferencia({super.key, required this.title, required this.isModoInclusao, this.item, required this.pessoaLogada});

  @override
  State<DialogEdicaoCadastroTransferencia> createState() => _DialogEdicaoCadastroTransferenciaState();
}

class _DialogEdicaoCadastroTransferenciaState extends State<DialogEdicaoCadastroTransferencia> {
  final _formKey = GlobalKey<FormState>();
  var codController = TextEditingController();
  var nomeController = TextEditingController();
  var nomeFocus = FocusNode();
  var barraCarregamento = false;
  CoberturaContratualReq coberturaContratualReq = CoberturaContratualReq();
  ConvenioReq convenioReq = ConvenioReq();
  EquipeTransporteReq equipeTransporteReq = EquipeTransporteReq();
  MeioTransporteReq meioTransporteReq = MeioTransporteReq();
  MotivoNaoAtendidaReq motivoNaoAtendidaReq = MotivoNaoAtendidaReq();
  MotivoRejeitadoReq motivoRejeitadoReq = MotivoRejeitadoReq();
  MotivoReq motivoReq = MotivoReq();
  MotivoSolicitacaoReq motivoSolicitacaoReq = MotivoSolicitacaoReq();
  PrecaucaoReq precaucaoReq = PrecaucaoReq();
  TipoInternacaoReq tipoInternacaoReq = TipoInternacaoReq();
  Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    var cadastro = CRUDCadastro();

    Future<void> enter() async {
      if (!barraCarregamento) {
        if (nomeController.text.isEmpty) nomeFocus.requestFocus();
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          _mostrarBarraCarregamento();
          cadastro.idEmp = widget.pessoaLogada.usuario?.empresa?.id;
          cadastro.idUni = widget.pessoaLogada.unidades?.first.idUni;
          cadastro.idUsuAlt = widget.pessoaLogada.usuario?.id;
          if (widget.isModoInclusao) {
            if (widget.title == 'Cobertura Contratual') {
              await coberturaContratualReq.reqIncluirCoberturaContratual(cadastro, context);
            } else if (widget.title == 'Convênio') {
              await convenioReq.reqIncluirConvenio(cadastro, context);
            } else if (widget.title == 'Equipe de Transporte') {
              await equipeTransporteReq.reqIncluirEquipeTransporte(cadastro, context);
            } else if (widget.title == 'Meio de Transporte') {
              await meioTransporteReq.reqIncluirMeioTransporte(cadastro, context);
            } else if (widget.title == 'Motivo') {
              await motivoReq.reqIncluirMotivo(cadastro, context);
            } else if (widget.title == 'Motivo da Transferência') {
              await motivoNaoAtendidaReq.reqIncluirMotivoNaoAtendida(cadastro, context);
            } else if (widget.title == 'Motivo Rejeitado') {
              await motivoRejeitadoReq.reqIncluirMotivoRejeitado(cadastro, context);
            } else if (widget.title == 'Motivo Solicitação') {
              await motivoSolicitacaoReq.reqIncluirMotivoSolicitacao(cadastro, context);
            } else if (widget.title == 'Precaução') {
              await precaucaoReq.reqIncluirPrecaucao(cadastro, context);
            } else if (widget.title == 'Tipo de Internação') {
              await tipoInternacaoReq.reqIncluirTipoInternacao(cadastro, context);
            }
          } else {
            cadastro.id = widget.item.id;
            cadastro.dtInc = widget.item.dtInc;
            cadastro.dtAlt = widget.item.dtAlt;
            if (widget.title == 'Cobertura Contratual') {
              await coberturaContratualReq.reqAlterarCoberturaContratual(cadastro, widget.item.id, context);
            } else if (widget.title == 'Convênio') {
              await convenioReq.reqAlterarConvenio(cadastro, widget.item.id, context);
            } else if (widget.title == 'Equipe de Transporte') {
              await equipeTransporteReq.reqAlterarEquipeTransporte(cadastro, widget.item.id, context);
            } else if (widget.title == 'Meio de Transporte') {
              await meioTransporteReq.reqAlterarMeioTransporte(cadastro, widget.item.id, context);
            } else if (widget.title == 'Motivo') {
              await motivoReq.reqAlterarMotivo(cadastro, widget.item.id, context);
            } else if (widget.title == 'Motivo da Transferência') {
              await motivoNaoAtendidaReq.reqAlterarMotivoNaoAtendida(cadastro, widget.item.id, context);
            } else if (widget.title == 'Motivo Rejeitado') {
              await motivoRejeitadoReq.reqAlterarMotivoRejeitado(cadastro, widget.item.id, context);
            } else if (widget.title == 'Motivo Solicitação') {
              await motivoSolicitacaoReq.reqAlterarMotivoSolicitacao(cadastro, widget.item.id, context);
            } else if (widget.title == 'Precaução') {
              await precaucaoReq.reqAlterarPrecaucao(cadastro, widget.item.id, context);
            } else if (widget.title == 'Tipo de Internação') {
              await tipoInternacaoReq.reqAlterarTipoInternacao(cadastro, widget.item.id, context);
            }
          }
          _limparCampos();
          _mostrarBarraCarregamento();
          Navigator.of(context).pop();
        }
      }
    }

    Future<void> excluir() async {
      _mostrarBarraCarregamento();
      bool confirmation = false;
      await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Tem certeza que deseja excluir o(a) \n${widget.title}: "${nomeController.text}"'),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(
                    onPressed: () {
                      confirmation = true;
                      Navigator.of(context).pop();
                    },
                    buttonColor: Colors.red,
                    margin: EdgeInsets.all(8),
                    text: 'SIM',
                  ),
                  Button(onPressed: () => Navigator.of(context).pop(), buttonColor: Colors.blueAccent, margin: EdgeInsets.all(8), text: 'NÃO'),
                ],
              ),
            ],
          );
        },
      );
      if (confirmation) {
        if (widget.title == 'Cobertura Contratual') {
          await coberturaContratualReq.reqExcluirCoberturaContratual(widget.item.id, context);
        } else if (widget.title == 'Convênio') {
          await convenioReq.reqExcluirConvenio(widget.item.id, context);
        } else if (widget.title == 'Equipe de Transporte') {
          await equipeTransporteReq.reqExcluirEquipeTransporte(widget.item.id, context);
        } else if (widget.title == 'Meio de Transporte') {
          await meioTransporteReq.reqExcluirMeioTransporte(widget.item.id, context);
        } else if (widget.title == 'Motivo') {
          await motivoReq.reqExcluirMotivo(widget.item.id, context);
        } else if (widget.title == 'Motivo da Transferência') {
          await motivoNaoAtendidaReq.reqExcluirMotivoNaoAtendida(widget.item.id, context);
        } else if (widget.title == 'Motivo Rejeitado') {
          await motivoRejeitadoReq.reqExcluirMotivoRejeitado(widget.item.id, context);
        } else if (widget.title == 'Motivo Solicitação') {
          await motivoSolicitacaoReq.reqExcluirMotivoSolicitacao(widget.item.id, context);
        } else if (widget.title == 'Precaução') {
          await precaucaoReq.reqExcluirPrecaucao(widget.item.id, context);
        } else if (widget.title == 'Tipo de Internação') {
          await tipoInternacaoReq.reqExcluirTipoInternacao(widget.item.id, context);
        }
      }
      _mostrarBarraCarregamento();
      Navigator.of(context).pop();
    }

    return SimpleDialog(
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
          color: theme.colorScheme.secondary,
        ),
        padding: EdgeInsets.all(8),
        child: Text(
          widget.isModoInclusao ? 'Inclusão de ${widget.title}' : 'Alteração de ${widget.title}',
          style: TextStyle(color: theme.colorScheme.onSecondary),
        ),
      ),
      children: [
        SizedBox(
          width: Responsive.isLargeScreen(context) ? size.width * 0.3 : size.width * 0.9,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: FormTextField(
                              onSaved: (p0) => cadastro.codigo = int.tryParse(p0!),
                              margin: const EdgeInsets.all(8),
                              inputFormatters: [utils.onlyNumbers],
                              controller: codController,
                              enter: () => enter(),
                              enabled: false,
                              text: 'Cod',
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: FormTextField(
                              validator: (p0) => utils.fieldValidation(p0, 'Nome'),
                              onSaved: (p0) => cadastro.nome = p0,
                              margin: const EdgeInsets.all(8),
                              controller: nomeController,
                              focusNode: nomeFocus,
                              enter: () => enter(),
                              text: 'Nome',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                loadingBar(barraCarregamento),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (widget.isModoInclusao) Button(onPressed: () => enter(), buttonColor: Colors.orange, margin: EdgeInsets.all(8), text: 'Incluir'),
                    if (!widget.isModoInclusao) Button(onPressed: () => enter(), buttonColor: Colors.orange, margin: EdgeInsets.all(8), text: 'Alterar'),
                    if (!widget.isModoInclusao) Button(onPressed: () => excluir(), buttonColor: Colors.red, margin: EdgeInsets.all(8), text: 'Excluir'),
                    Button(onPressed: () => Navigator.of(context).pop(), buttonColor: Colors.blueAccent, margin: EdgeInsets.all(8), text: 'Fechar'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    codController.dispose();
    nomeController.dispose();
    nomeFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    nomeFocus.requestFocus();
    codController.text = widget.item.codigo != null ? widget.item.codigo.toString() : '';
    nomeController.text = widget.item.nome ?? '';
  }

  void _limparCampos() {
    if (widget.isModoInclusao) {
      codController.clear();
      nomeController.clear();
    }
  }

  void _mostrarBarraCarregamento() {
    setState(() => barraCarregamento = !barraCarregamento);
  }
}
