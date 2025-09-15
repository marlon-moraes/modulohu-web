// 🌎 Project imports:
import 'package:modulohu_web/src/utils/shared_pref.dart';

final _sharedPref = SharedPref();

/// Valida se um usuário está logado.
///
/// A função [validarLogin] verifica se há uma sessão de usuário ativa
/// lendo o valor armazenado nas preferências compartilhadas. Se o valor
/// correspondente à chave 'pessoaLogada' não for nulo, a função retorna
/// `true`, indicando que o usuário está logado; caso contrário, retorna
/// `false`.
///
/// ## Retorno:
/// Retorna um `Future<bool>` que indica se o usuário está logado ou não.
///
/// ## Exemplo:
/// ```dart
/// bool isLoggedIn = await validarLogin();
/// if (isLoggedIn) {
///   print('Usuário está logado.');
/// } else {
///   print('Usuário não está logado.');
/// }
/// ```
///
/// ## Uso:
/// Esta função pode ser utilizada em qualquer parte da aplicação onde
/// seja necessário verificar o estado de autenticação do usuário.
/// É útil para proteger rotas ou exibir diferentes interfaces com base
/// no estado de login do usuário.
Future<bool> validarLogin() async {
  final retorno = await _sharedPref.read('pessoaLogada');
  if (retorno != null) return true;
  return false;
}
