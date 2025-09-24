// ignore_for_file: use_build_context_synchronously

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:components/components.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/crud_cadastro.dart';
import 'package:modulohu_web/src/models/user_action.dart';
import 'package:modulohu_web/src/services/api/req/assunto_req.dart';
import 'package:modulohu_web/src/services/api/req/canal_req.dart';
import 'package:modulohu_web/src/services/api/req/carater_atendimento_req.dart';
import 'package:modulohu_web/src/services/api/req/status_req.dart';
import 'package:modulohu_web/src/services/api/req/tipo_atendimento_req.dart';
import 'package:modulohu_web/src/utils/utils.dart';

class DialogEdicaoCadastro extends StatefulWidget {
  final String title;
  final bool isModoInclusao;
  final dynamic item;
  final UserAction pessoaLogada;

  const DialogEdicaoCadastro({super.key, required this.title, required this.isModoInclusao, required this.item, required this.pessoaLogada});

  @override
  State<DialogEdicaoCadastro> createState() => _DialogEdicaoCadastroState();
}

class _DialogEdicaoCadastroState extends State<DialogEdicaoCadastro> {
  final _formKey = GlobalKey<FormState>();
  var codController = TextEditingController();
  var nomeController = TextEditingController();
  var nomeFocus = FocusNode();
  var prazoController = TextEditingController();
  var prazoFocus = FocusNode();
  bool? _ativoValue;
  bool? _fixoValue;
  var barraCarregamento = false;
  AssuntoReq assuntoReq = AssuntoReq();
  CanalReq canalReq = CanalReq();
  CaraterAtendimentoReq caraterAtendimentoReq = CaraterAtendimentoReq();
  StatusReq statusReq = StatusReq();
  TipoAtendimentoReq tipoAtendimentoReq = TipoAtendimentoReq();
  Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    var cadastro = CRUDCadastro();

    Future<void> enter() async {
      if (!barraCarregamento) {
        if (nomeController.text.isEmpty) {
          nomeFocus.requestFocus();
        } else if (prazoController.text.isEmpty && widget.title == 'Tipo de Atendimento') {
          prazoFocus.requestFocus();
        }
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          _mostrarBarraCarregamento();
          cadastro.idEmp = widget.pessoaLogada.usuario?.empresa?.id;
          cadastro.idUni = widget.pessoaLogada.unidades?.first.idUni;
          cadastro.idUsuInc = widget.pessoaLogada.usuario?.id;
          cadastro.idUsuAlt = widget.pessoaLogada.usuario?.id;
          if (widget.isModoInclusao) {
            if (widget.title == 'Tipo de Atendimento') {
              await tipoAtendimentoReq.reqIncluirTipoAtendimento(cadastro, context);
            } else if (widget.title == 'Assunto') {
              await assuntoReq.reqIncluirAssunto(cadastro, context);
            } else if (widget.title == 'Canal') {
              await canalReq.reqIncluirCanal(cadastro, context);
            } else if (widget.title == 'Caráter de Atendimento') {
              await caraterAtendimentoReq.reqIncluirCaraterAtendimento(cadastro, context);
            } else if (widget.title == 'Status') {
              cadastro.ativo = _ativoValue;
              cadastro.fixo = _fixoValue;
              await statusReq.reqIncluirStatus(cadastro, context);
            }
          } else {
            cadastro.id = widget.item.id;
            cadastro.dtInc = widget.item.dtInc;
            cadastro.dtAlt = widget.item.dtAlt;
            if (widget.title == 'Tipo de Atendimento') {
              await tipoAtendimentoReq.reqAlterarTipoAtendimento(cadastro, context);
            } else if (widget.title == 'Assunto') {
              await assuntoReq.reqAlterarAssunto(cadastro, context);
            } else if (widget.title == 'Canal') {
              await canalReq.reqAlterarCanal(cadastro, context);
            } else if (widget.title == 'Caráter de Atendimento') {
              await caraterAtendimentoReq.reqAlterarCaraterAtendimento(cadastro, context);
            } else if (widget.title == 'Status') {
              cadastro.ativo = _ativoValue;
              cadastro.fixo = _fixoValue;
              await statusReq.reqAlterarStatus(cadastro, context);
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
            title: Text('Tem certeza que deseja excluir o \n${widget.title}: "${nomeController.text}"'),
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
        if (widget.title == 'Tipo de Atendimento') {
          await tipoAtendimentoReq.reqExcluirTipoAtendimento(widget.item.id, context);
        } else if (widget.title == 'Assunto') {
          await assuntoReq.reqExcluirAssunto(widget.item.id, context);
        } else if (widget.title == 'Canal') {
          await canalReq.reqExcluirCanal(widget.item.id, context);
        } else if (widget.title == 'Caráter de Atendimento') {
          await caraterAtendimentoReq.reqExcluirCaraterAtendimento(widget.item.id, context);
        } else if (widget.title == 'Status') {
          await statusReq.reqExcluirStatus(widget.item.id, context);
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
          width: Responsive.isLargeScreen(context) ? size.width * 0.3 : size.width,
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
                          if (widget.title == 'Tipo de Atendimento')
                            Expanded(
                              child: FormTextField(
                                onSaved: (p0) => cadastro.prazo = int.tryParse(p0!),
                                validator: (p0) => utils.fieldValidation(p0, 'Prazo'),
                                margin: const EdgeInsets.all(8),
                                inputFormatters: [utils.onlyNumbers],
                                controller: prazoController,
                                focusNode: prazoFocus,
                                enter: () => enter(),
                                text: 'Prazo',
                              ),
                            ),
                        ],
                      ),
                      if (widget.title == 'Status')
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Ativo?'),
                              // if (Responsive.isLargeScreen(context)) Expanded(child: SizedBox()),
                              Expanded(
                                child: RadioGroup(
                                  groupValue: _ativoValue,
                                  onChanged: (value) => setState(() => _ativoValue = value),
                                  child: const Row(
                                    children: [
                                      Expanded(flex: 2, child: RadioListTile(title: Text('Sim'), value: true)),
                                      Expanded(flex: 2, child: RadioListTile(title: Text('Não'), value: false)),
                                    ],
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   flex: 2,
                              //   child: RadioListTile(
                              //     title: const Text('Sim'),
                              //     value: true,
                              //     groupValue: _ativoValue,
                              //     onChanged: (value) => setState(() => _ativoValue = value),
                              //   ),
                              // ),
                              // Expanded(
                              //   flex: 2,
                              //   child: RadioListTile(
                              //     title: const Text('Não'),
                              //     value: false,
                              //     groupValue: _ativoValue,
                              //     onChanged: (value) => setState(() => _ativoValue = value),
                              //   ),
                              // ),
                              // if (Responsive.isLargeScreen(context)) Expanded(child: SizedBox()),
                            ],
                          ),
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
    prazoController.dispose();
    prazoFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    nomeFocus.requestFocus();
    codController.text = widget.item.codigo != null ? widget.item.codigo.toString() : '';
    nomeController.text = widget.item.nome ?? '';
    if (widget.title == 'Tipo de Atendimento') prazoController.text = widget.item.prazo != null ? widget.item.prazo.toString() : '';
    if (widget.title == 'Status') {
      _ativoValue = widget.item.ativo ?? true;
      _fixoValue = widget.item.fixo ?? false;
    }
  }

  void _limparCampos() {
    if (widget.isModoInclusao) {
      codController.clear();
      nomeController.clear();
      prazoController.clear();
      setState(() {
        _ativoValue = null;
        _fixoValue = null;
      });
    }
  }

  void _mostrarBarraCarregamento() {
    setState(() => barraCarregamento = !barraCarregamento);
  }
}
