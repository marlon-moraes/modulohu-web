// 🎯 Dart imports:
import 'dart:convert';

// 📦 Package imports:
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

/// Interceptor para registrar requisições e respostas HTTP.
///
/// A classe [LoggingInterceptor] implementa a interface [InterceptorContract]
/// e é responsável por interceptar e registrar informações sobre as requisições
/// e respostas HTTP. Ela utiliza o pacote [logger] para registrar logs em
/// diferentes níveis de severidade, dependendo do código de status da resposta.
///
/// ## Métodos:
///
/// ### interceptRequest
/// Intercepta uma requisição HTTP antes de ser enviada.
///
/// - **Parâmetros:**
///   - [data]: Um objeto [RequestData] que contém informações sobre a requisição,
///     como URL, cabeçalhos, parâmetros e corpo.
///
/// - **Retorno:**
///   Retorna um `Future<RequestData>` com os dados da requisição, permitindo
///   que a requisição prossiga.
///
/// - **Exemplo de Uso:**
/// ```dart
/// final interceptor = LoggingInterceptor();
/// final requestData = await interceptor.interceptRequest(data: requestData);
/// ```
///
/// ### interceptResponse
/// Intercepta uma resposta HTTP após ser recebida.
///
/// - **Parâmetros:**
///   - [data]: Um objeto [ResponseData] que contém informações sobre a resposta,
///     como URL, código de status, cabeçalhos e corpo.
///
/// - **Retorno:**
///   Retorna um `Future<ResponseData>` com os dados da resposta, permitindo
///   que a resposta prossiga.
///
/// - **Exemplo de Uso:**
/// ```dart
/// final responseData = await interceptor.interceptResponse(data: responseData);
/// ```
///
/// ## Níveis de Log:
/// A classe registra as informações da resposta em diferentes níveis de log,
/// dependendo do código de status:
/// - **1xx (Informativo):** Log de informação.
/// - **2xx (Sucesso):** Log de depuração.
/// - **3xx (Redirecionamento):** Log de informação.
/// - **4xx (Erro do cliente):** Log de erro.
/// - **5xx (Erro do servidor):** Log de aviso.
///
/// ## Uso:
/// Esta classe pode ser utilizada em qualquer parte da aplicação onde
/// seja necessário monitorar e registrar as requisições e respostas HTTP.
/// É útil para depuração e análise de problemas em chamadas de API.
class LoggingInterceptor implements InterceptorContract {
  final logger = Logger();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    logger.t(
      'REQUEST TO: ${data.baseUrl}\n'
      'HEADERS: ${data.headers}\n'
      '${data.params.isNotEmpty ? "PARAMS: ${data.params}\n" : ""}'
      'METHOD: ${data.method}\n'
      'BODY: ${data.body}',
    );
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    var logMessage =
        'RESPONSE FROM: ${data.url}\n'
        'STATUS CODE: ${data.statusCode}\n'
        'HEADERS: ${data.headers}\n'
        'BODY: ${utf8.decode(data.bodyBytes)}';
    var statusCodeCategory = data.statusCode ~/ 100;
    switch (statusCodeCategory) {
      case 1: // Informativo
        logger.i(logMessage);
        break;
      case 2: // Sucesso
        logger.d(logMessage);
        break;
      case 3: // Redirecionamento
        logger.i(logMessage);
        break;
      case 4: // Erro do cliente
        logger.e(logMessage);
        break;
      case 5: // Erro do servidor
        logger.w(logMessage);
        break;
      default: // Teoricamente impossível de cair
        logger.f('CHAPOU NA LINGUIÇA!');
    }
    return data;
  }
}
