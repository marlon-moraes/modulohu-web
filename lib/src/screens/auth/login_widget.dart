// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:seletor_cidade_por_uf/seletor_cidade_por_uf.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/services/api/req/auth_req.dart';
import 'package:modulohu_web/src/utils/utils.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  static const _apiEnv = String.fromEnvironment('API_ENV', defaultValue: 'homologacao');
  final _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final userFocus = FocusNode();
  final secretFocus = FocusNode();
  final passWordController = TextEditingController();
  final passwordFocus = FocusNode();
  var barraCarregamento = false;
  AuthReq authReq = AuthReq();
  Utils utils = Utils();

  Future<void> _logar() async {
    if (!barraCarregamento) {
      if (userController.text.isEmpty) {
        userFocus.requestFocus();
      } else if (passWordController.text.isEmpty) {
        passwordFocus.requestFocus();
      }
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        _mostrarBarraCarregamento();
        var res = await authReq.reqLogon(userController.text, passWordController.text, context);
        if (!context.mounted) return;
        if (res) {
          userController.clear();
          passWordController.clear();
        }
        _mostrarBarraCarregamento();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [BoxShadow(offset: Offset(5, 5), color: Colors.grey, spreadRadius: 0.5, blurRadius: 5)],
          color: theme.cardColor,
        ),
        child: Column(
          children: [
            Container(
              color: theme.colorScheme.primary,
              height: 50,
              child: Center(child: Text('Login', style: TextStyle(fontSize: theme.textTheme.titleLarge!.fontSize, color: theme.colorScheme.onPrimary))),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01, vertical: 8),
              child: Column(
                children: [
                  FormTextField(
                    validator: (p0) => utils.fieldValidation(p0, 'Usuário'),
                    margin: const EdgeInsets.all(8),
                    inputFormatters: [utils.onlyNumbers],
                    controller: userController,
                    enter: () => _logar(),
                    focusNode: userFocus,
                    icon: Icons.person,
                    autoFocus: true,
                    text: 'Usuário',
                  ),
                  KeyboardListener(
                    onKeyEvent: (value) {
                      if (value.logicalKey == LogicalKeyboardKey.tab) FocusScope.of(context).nextFocus();
                    },
                    focusNode: secretFocus,
                    child: FormTextField(
                      validator: (p0) => utils.fieldValidation(p0, 'Senha'),
                      margin: const EdgeInsets.all(8),
                      controller: passWordController,
                      focusNode: passwordFocus,
                      enter: () => _logar(),
                      isPasswordField: true,
                      text: 'Senha',
                    ),
                  ),
                  loadingBar(barraCarregamento),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        contentColor: theme.colorScheme.onSecondary,
                        buttonColor: theme.colorScheme.secondary,
                        margin: const EdgeInsets.all(8),
                        leftIcon: Icons.login_outlined,
                        onPressed: () => _logar(),
                        text: 'OK',
                      ),
                    ],
                  ),
                  // SeletorCidadePorUf(onSaved: (value) {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    userController.dispose();
    userFocus.dispose();
    secretFocus.dispose();
    passWordController.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (_apiEnv == 'local') {
      userController.text = '1';
      passWordController.text = 'm3r1t0crm!';
      // userController.text = '35901';
      // passWordController.text = 'LILICA@2015';
    } else {
      userFocus.requestFocus();
    }
  }

  void _mostrarBarraCarregamento() {
    setState(() => barraCarregamento = !barraCarregamento);
  }
}
