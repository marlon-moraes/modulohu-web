// ignore_for_file: use_build_context_synchronously

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:components/components.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/user_action.dart';
import 'package:modulohu_web/src/services/api/req/auth_req.dart';
import 'package:modulohu_web/src/utils/utils.dart';

class DialogTrocarSenha extends StatefulWidget {
  final String userCode;

  const DialogTrocarSenha({super.key, required this.userCode});

  @override
  State<DialogTrocarSenha> createState() => _DialogTrocarSenhaState();
}

class _DialogTrocarSenhaState extends State<DialogTrocarSenha> {
  final _formKey = GlobalKey<FormState>();

  final userController = TextEditingController();
  final userFocus = FocusNode();
  final currentSecretFocus = FocusNode();
  final currentPasswordController = TextEditingController();
  final currentPasswordFocus = FocusNode();
  final newSecretFocus = FocusNode();
  final newPasswordController = TextEditingController();
  final newPasswordFocus = FocusNode();
  final confirmSecretFocus = FocusNode();
  final confirmPasswordController = TextEditingController();
  final confirmPasswordFocus = FocusNode();
  var pessoaLogada = UserAction();
  var barraCarregamento = false;
  var dezCaracteres = false;
  var capitalLetter = false;
  var letraMinuscula = false;
  var contemNumero = false;
  var contemSimbolo = false;
  var mesmaSenha = false;
  AuthReq authReq = AuthReq();
  Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget haveTenCharacters() {
      return Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(dezCaracteres ? Icons.check_box : Icons.disabled_by_default_rounded, color: dezCaracteres ? Colors.green : Colors.red),
            const Text(' 10 caracteres'),
          ],
        ),
      );
    }

    Widget haveOneCapitalLetter() {
      return Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(capitalLetter ? Icons.check_box : Icons.disabled_by_default_rounded, color: capitalLetter ? Colors.green : Colors.red),
            const Text(' 1 letra maiúscula'),
          ],
        ),
      );
    }

    Widget haveOneLowercaseLetter() {
      return Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(letraMinuscula ? Icons.check_box : Icons.disabled_by_default_rounded, color: letraMinuscula ? Colors.green : Colors.red),
            const Text(' 1 letra minúscula'),
          ],
        ),
      );
    }

    Widget haveOneNumber() {
      return Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(contemNumero ? Icons.check_box : Icons.disabled_by_default_rounded, color: contemNumero ? Colors.green : Colors.red),
            const Text(' 1 número'),
          ],
        ),
      );
    }

    Widget haveOneSpecialCharacter() {
      return Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(contemSimbolo ? Icons.check_box : Icons.disabled_by_default_rounded, color: contemSimbolo ? Colors.green : Colors.red),
            const Text(' 1 caractere especial'),
          ],
        ),
      );
    }

    Widget newPasswordConfirmation() {
      return Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(mesmaSenha ? Icons.check_box : Icons.disabled_by_default_rounded, color: mesmaSenha ? Colors.green : Colors.red),
            const Text(' Confirmar a nova senha'),
          ],
        ),
      );
    }

    Future<void> trocarSenha() async {
      if (!barraCarregamento) {
        var retorno = false;
        var errors = 'Regras de senha pendentes:\n';
        if (dezCaracteres && capitalLetter && letraMinuscula && contemNumero && contemSimbolo && mesmaSenha) {
          if (userController.text.isEmpty) {
            userFocus.requestFocus();
          } else if (currentPasswordController.text.isEmpty) {
            currentPasswordFocus.requestFocus();
          } else if (newPasswordController.text.isEmpty) {
            newPasswordFocus.requestFocus();
          } else if (confirmPasswordController.text.isEmpty) {
            confirmPasswordFocus.requestFocus();
          }
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            _mostrarBarraCarregamento();
            retorno = await authReq.reqAlterarSenha(userController.text, newPasswordController.text, context);
          }
          if (retorno) {
            _mostrarBarraCarregamento();
            Navigator.pop(context);
            Message('Faça o Login novamente para continuar', true).inputMsg(context);
          }
        } else {
          if (!dezCaracteres) errors += '\n  - mínimo de 10 caracteres';
          if (!capitalLetter) errors += '\n  - deve conter ao menos 1 letra maiúscula';
          if (!letraMinuscula) errors += '\n  - deve conter ao menos 1 letra minúscula';
          if (!contemNumero) errors += '\n  - deve conter ao menos 1 número';
          if (!contemSimbolo) errors += '\n  - deve conter ao menos 1 caractere especial';
          if (!mesmaSenha) errors += '\n  - confirmação de nova senha deve ser igual a nova senha';
          showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(errors, textAlign: TextAlign.start)));
        }
        if (barraCarregamento) _mostrarBarraCarregamento();
      }
    }

    return AlertDialog(
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
          color: theme.colorScheme.secondary,
        ),
        padding: EdgeInsets.all(4),
        child: Center(child: Text('Alterar Senha', style: TextStyle(color: theme.colorScheme.onSecondary))),
      ),
      actionsPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(4),
      titlePadding: EdgeInsets.all(0),
      content: SizedBox(
        height: Responsive.isLargeScreen(context) ? 338 : 410,
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormTextField(
                        validator: (p0) => utils.fieldValidation(p0, 'Usuário'),
                        margin: const EdgeInsets.all(8),
                        inputFormatters: [utils.onlyNumbers],
                        controller: userController,
                        enter: () => trocarSenha(),
                        focusNode: userFocus,
                        icon: Icons.person,
                        text: 'Usuário',
                        enabled: false,
                      ),
                      KeyboardListener(
                        onKeyEvent: (value) {
                          if (value.logicalKey == LogicalKeyboardKey.tab) newSecretFocus.nextFocus();
                        },
                        focusNode: newSecretFocus,
                        child: FormTextField(
                          onChanged: (p0) {
                            if (p0.length > 9) {
                              setState(() => dezCaracteres = true);
                            } else {
                              setState(() => dezCaracteres = false);
                            }
                            if (p0.contains(RegExp(r'[A-Z]'))) {
                              setState(() => capitalLetter = true);
                            } else {
                              setState(() => capitalLetter = false);
                            }
                            if (p0.contains(RegExp(r'[a-z]'))) {
                              setState(() => letraMinuscula = true);
                            } else {
                              setState(() => letraMinuscula = false);
                            }
                            if (p0.contains(RegExp(r'[0-9]'))) {
                              setState(() => contemNumero = true);
                            } else {
                              setState(() => contemNumero = false);
                            }
                            if (p0.contains(RegExp(r'[^A-Za-z0-9]'))) {
                              setState(() => contemSimbolo = true);
                            } else {
                              setState(() => contemSimbolo = false);
                            }
                            if (newPasswordController.text.length == confirmPasswordController.text.length) {
                              if (confirmPasswordController.text == newPasswordController.text) {
                                setState(() => mesmaSenha = true);
                              } else {
                                setState(() => mesmaSenha = false);
                              }
                            } else {
                              setState(() => mesmaSenha = false);
                            }
                            if (newPasswordController.text.isEmpty || confirmPasswordController.text.isEmpty) setState(() => mesmaSenha = false);
                          },
                          validator: (p0) => utils.fieldValidation(p0, 'Nova Senha'),
                          controller: newPasswordController,
                          margin: const EdgeInsets.all(8),
                          focusNode: newPasswordFocus,
                          enter: () => trocarSenha(),
                          isPasswordField: true,
                          icon: Icons.person,
                          text: 'Nova Senha',
                        ),
                      ),
                      KeyboardListener(
                        onKeyEvent: (value) {
                          if (value.logicalKey == LogicalKeyboardKey.tab) confirmSecretFocus.nextFocus();
                        },
                        focusNode: confirmSecretFocus,
                        child: FormTextField(
                          onChanged: (p0) {
                            if (newPasswordController.text.length == confirmPasswordController.text.length) {
                              if (confirmPasswordController.text == newPasswordController.text) {
                                setState(() => mesmaSenha = true);
                              } else {
                                setState(() => mesmaSenha = false);
                              }
                            } else {
                              setState(() => mesmaSenha = false);
                            }
                            if (confirmPasswordController.text.isEmpty || newPasswordController.text.isEmpty) setState(() => mesmaSenha = false);
                          },
                          validator: (p0) => utils.fieldValidation(p0, 'Confirmar Nova Senha'),
                          controller: confirmPasswordController,
                          focusNode: confirmPasswordFocus,
                          margin: const EdgeInsets.all(8),
                          text: 'Confirmar Nova Senha',
                          enter: () => trocarSenha(),
                          isPasswordField: true,
                        ),
                      ),
                      loadingBar(barraCarregamento),
                      Container(margin: const EdgeInsets.only(left: 8, top: 4, right: 8, bottom: 2), child: const Text('Regras de Formatação da Senha:')),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child:
                            Responsive.isLargeScreen(context)
                                ? Column(
                                  children: [
                                    Row(children: [haveTenCharacters(), haveOneCapitalLetter()]),
                                    Row(children: [haveOneLowercaseLetter(), haveOneNumber()]),
                                    Row(children: [haveOneSpecialCharacter(), newPasswordConfirmation()]),
                                  ],
                                )
                                : Column(
                                  children: [
                                    Row(children: [haveTenCharacters()]),
                                    Row(children: [haveOneCapitalLetter()]),
                                    Row(children: [haveOneLowercaseLetter()]),
                                    Row(children: [haveOneNumber()]),
                                    Row(children: [haveOneSpecialCharacter()]),
                                    Row(children: [newPasswordConfirmation()]),
                                  ],
                                ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Button(
                            contentColor: theme.colorScheme.onSecondary,
                            buttonColor: theme.colorScheme.secondary,
                            margin: const EdgeInsets.all(8),
                            onPressed: () => trocarSenha(),
                            text: 'Alterar Senha',
                          ),
                          Button(
                            contentColor: theme.colorScheme.onTertiary,
                            buttonColor: theme.colorScheme.tertiary,
                            onPressed: () => Navigator.pop(context),
                            margin: const EdgeInsets.all(8),
                            text: 'Cancelar',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    userController.dispose();
    userFocus.dispose();
    currentSecretFocus.dispose();
    currentPasswordController.dispose();
    currentPasswordFocus.dispose();
    newSecretFocus.dispose();
    newPasswordController.dispose();
    newPasswordFocus.dispose();
    confirmSecretFocus.dispose();
    confirmPasswordController.dispose();
    confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userController.text = widget.userCode;
  }

  void _mostrarBarraCarregamento() {
    setState(() => barraCarregamento = !barraCarregamento);
  }
}
