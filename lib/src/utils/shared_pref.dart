// 📦 Package imports:
import 'package:shared_preferences/shared_preferences.dart';

/// Uma classe para gerenciar preferências compartilhadas.
///
/// A classe [SharedPref] fornece métodos para ler, salvar, remover
/// e limpar dados armazenados nas preferências compartilhadas. Isso
/// é útil para persistir informações entre sessões de aplicativo,
/// como tokens de autenticação e configurações do usuário.
///
/// ## Métodos:
///
/// ### read
/// Lê um valor armazenado nas preferências compartilhadas.
///
/// - **Parâmetros:**
///   - [key]: A chave do valor a ser lido.
///
/// - **Retorno:**
///   Retorna uma `Future<String?>` que contém o valor associado à
///   chave, ou `null` se a chave não existir.
///
/// ### remove
/// Remove um valor armazenado nas preferências compartilhadas.
///
/// - **Parâmetros:**
///   - [key]: A chave do valor a ser removido.
///
/// - **Retorno:**
///   Retorna uma `Future<void>`.
///
/// ### reset
/// Limpa todas as preferências armazenadas.
///
/// - **Retorno:**
///   Retorna uma `Future<void>`.
///
/// ### save
/// Salva um valor nas preferências compartilhadas.
///
/// - **Parâmetros:**
///   - [key]: A chave sob a qual o valor será armazenado.
///   - [value]: O valor a ser armazenado.
///
/// - **Retorno:**
///   Retorna uma `Future<void>`.
///
/// ## Exemplo de Uso:
/// ```dart
/// final sharedPref = SharedPref();
/// await sharedPref.save('token', '123456');
/// String? token = await sharedPref.read('token');
/// print(token); // Saída: '123456'
/// await sharedPref.remove('token');
/// ```
///
/// ## Uso:
/// Esta classe pode ser utilizada em qualquer parte da aplicação onde
/// seja necessário gerenciar preferências compartilhadas. Ela fornece
/// uma interface simples para armazenar e recuperar dados persistentes.
class SharedPref {
  Future<String?> read(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  Future<void> remove(String key) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  Future<void> reset() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future<void> save(String key, String value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }
}
