// 📦 Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Uma classe para gerenciar variáveis de ambiente.
///
/// A classe [Environment] fornece métodos para acessar variáveis de
/// ambiente definidas em um arquivo `.env`. Isso é útil para
/// configurar parâmetros da aplicação, como o nome do aplicativo e
/// a URL base da API.
///
/// ## Métodos:
///
/// ### getAppName
/// Retorna o nome do aplicativo definido na variável de ambiente `TITLE`.
///
/// - **Retorno:**
///   Uma `String?` que contém o nome do aplicativo ou `null` se a
///   variável não estiver definida.
///
/// ### getHost
/// Retorna a URL base da API definida na variável de ambiente `BASE_URL`.
///
/// - **Retorno:**
///   Uma `String?` que contém a URL base ou `null` se a variável
///   não estiver definida.
///
/// ## Exemplo de Uso:
/// ```dart
/// String appName = Environment.getAppName() ?? 'Nome Padrão';
/// String apiUrl = Environment.getHost() ?? 'https://api.exemplo.com';
/// print('App: $appName, API: $apiUrl');
/// ```
///
/// ## Uso:
/// Esta classe pode ser utilizada em qualquer parte da aplicação onde
/// seja necessário acessar variáveis de configuração. Ela fornece uma
/// maneira centralizada de gerenciar configurações sensíveis e específicas
/// do ambiente.
class Environment {
  static String getAppName() => dotenv.get('TITLE', fallback: null);

  static String getHost() => dotenv.get('BASE_URL', fallback: null);
}

final String title = Environment.getAppName();
final String host = Environment.getHost();
