// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/utils/shared_pref.dart';

SharedPref _sharedPref = SharedPref();

/// Realiza o logout do usuário.
///
/// A função [logout] é responsável por encerrar a sessão do usuário
/// ao limpar as preferências compartilhadas e redirecionar o usuário
/// para a página inicial da aplicação.
///
/// ## Parâmetros:
/// - [context]: O contexto do widget que chama a função, necessário
///   para realizar a navegação.
///
/// ## Comportamento:
/// - A função chama o método `reset` da classe [SharedPref] para limpar
///   os dados armazenados relacionados à sessão do usuário.
/// - Em seguida, utiliza o método `replace` do [GoRouter] para redirecionar
///   o usuário para a rota inicial (`'/'`).
///
/// ## Exemplo:
/// ```dart
/// ElevatedButton(
///   onPressed: () => logout(context),
///   child: Text('Sair'),
/// )
/// ```
///
/// ## Uso:
/// Esta função pode ser utilizada em qualquer parte da aplicação onde
/// seja necessário realizar o logout do usuário. É útil em botões de
/// logout ou em menus de navegação.
void logout(BuildContext context) {
  _sharedPref.reset();
  context.replace('/');
}
