// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:convert';
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:components/components.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging_interceptor/logging_interceptor.dart';

// 🌎 Project imports:
import 'package:modulohu_web/environment.dart' as env;
import 'package:modulohu_web/src/utils/api_exception.dart';
import 'package:modulohu_web/src/utils/constants.dart';

/// Classe responsável por realizar requisições HTTP para a API.
///
/// A classe [Requisition] encapsula a lógica de envio de requisições HTTP
/// utilizando diferentes métodos (GET, POST, PUT, DELETE, PATCH, HEAD).
/// Ela utiliza um cliente HTTP com interceptor para registrar logs das
/// requisições e respostas, além de tratar erros e exibir mensagens
/// amigáveis ao usuário.
///
/// ## Propriedades:
/// - [endpoint]: Endpoint da API para o qual a requisição será enviada.
/// - [params]: Parâmetros opcionais para a requisição.
/// - [client]: Instância do cliente HTTP com interceptor de logging.
///
/// ## Métodos:
///
/// ### req
/// Realiza uma requisição HTTP para o endpoint especificado, utilizando o método informado.
///
/// - **Parâmetros:**
///   - [method]: Enum [HttpRequests] que define o tipo de requisição (GET, POST, etc).
///   - [json]: Corpo da requisição (para métodos que aceitam body).
///   - [context]: Contexto do widget, utilizado para exibir dialogs de erro.
///   - [header]: Cabeçalhos opcionais para a requisição.
///
/// - **Retorno:**
///   Retorna um `Future<http.Response?>` com a resposta da requisição, ou `null` em caso de erro.
///
/// - **Tratamento de Erros:**
///   - Erros de conexão (ex: sem internet) lançam uma [ApiException].
///   - Erros de status HTTP (ex: 400, 403, 404, 409, 500) são tratados e exibidos via dialog.
///   - Mensagens de erro são extraídas do corpo da resposta ou exibidas como HTML se necessário.
///
/// ## Exemplo de Uso:
/// ```dart
/// final requisition = Requisition('/api/endpoint');
/// final response = await requisition.req(HttpRequests.GET, null, context);
/// if (response != null) {
///   print(response.body);
/// }
/// ```
///
/// ## Uso:
/// Utilize esta classe para realizar chamadas à API em qualquer parte da aplicação.
/// Ela centraliza o tratamento de erros e facilita o envio de requisições HTTP.
class Requisition {
  final String endpoint;
  final Map<String, dynamic>? params;

  Requisition(this.endpoint, {this.params});

  http.Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  Future<http.Response?> req(HttpRequests method, dynamic json, BuildContext context, {Map<String, String>? header}) async {
    http.Response response;
    try {
      switch (method) {
        case HttpRequests.GET:
          response = await client.get(Uri.parse('${env.host}$endpoint'), headers: header);
          break;
        case HttpRequests.HEAD:
          response = await client.head(Uri.parse('${env.host}$endpoint'), headers: header);
          break;
        case HttpRequests.POST:
          response = await client.post(Uri.parse('${env.host}$endpoint'), headers: header, body: jsonEncode(json));
          break;
        case HttpRequests.PUT:
          response = await client.put(Uri.parse('${env.host}$endpoint'), headers: header, body: jsonEncode(json));
          break;
        case HttpRequests.DELETE:
          response = await client.delete(Uri.parse('${env.host}$endpoint'), headers: header, body: jsonEncode(json));
          break;
        case HttpRequests.PATCH:
          response = await client.patch(Uri.parse('${env.host}$endpoint'), headers: header, body: jsonEncode(json));
          break;
        default:
          throw ApiException('Método da requisição não foi identificado');
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else if (response.statusCode >= 300 && response.statusCode < 400) {
        if (response.statusCode == 304) {
          throw ApiException(
            jsonDecode(utf8.decode(response.bodyBytes))['mensagem'] ??
                jsonDecode(utf8.decode(response.bodyBytes))['erro'] ??
                '304 - Erro na Alteração dos Dados',
          );
        } else {
          throw ApiException(
            jsonDecode(utf8.decode(response.bodyBytes))['mensagem'] ?? jsonDecode(utf8.decode(response.bodyBytes))['erro'] ?? '300 Bad Redirect',
          );
        }
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        if (response.body.contains('<!doctype html>')) {
          throw ApiException(response.body);
        } else if (response.body.contains('"erro":[')) {
          String erroStack = '';
          for (var i = 0; i < jsonDecode(utf8.decode(response.bodyBytes))['erro'].length; i++) {
            erroStack += jsonDecode(utf8.decode(response.bodyBytes))['erro'][i] + '\n';
          }
          throw ApiException(erroStack);
        } else if (response.statusCode == 403) {
          throw ApiException(
            jsonDecode(utf8.decode(response.bodyBytes))['mensagem'] ??
                jsonDecode(utf8.decode(response.bodyBytes))['erro'] ??
                '403 - Recurso não acessível para o usuário',
          );
        } else if (response.statusCode == 404) {
          throw ApiException(
            jsonDecode(utf8.decode(response.bodyBytes))['mensagem'] ?? jsonDecode(utf8.decode(response.bodyBytes))['erro'] ?? '404 - Recurso não encontrado',
          );
        } else if (response.statusCode == 409) {
          throw ApiException(
            jsonDecode(utf8.decode(response.bodyBytes))['mensagem'] ??
                jsonDecode(utf8.decode(response.bodyBytes))['erro'] ??
                '409 - Recurso já cadastrado ou dados incorretos',
          );
        } else {
          throw ApiException(
            jsonDecode(utf8.decode(response.bodyBytes))['mensagem'] ?? jsonDecode(utf8.decode(response.bodyBytes))['erro'] ?? '400 Bad Request',
          );
        }
      } else {
        if (response.body.contains('<!doctype html>')) {
          throw ApiException(response.body);
        } else {
          throw ApiException(
            jsonDecode(utf8.decode(response.bodyBytes))['mensagem'] ?? jsonDecode(utf8.decode(response.bodyBytes))['erro'] ?? '500 - Erro do Servidor Interno',
          );
        }
      }
    } on SocketException {
      throw ApiException('Sem Conexão com a Internet');
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) {
          return Alert(success: false, isModal: false, child: e.toString().contains('<!doctype html>') ? Html(data: e.toString()) : Text(e.toString()));
        },
      );
    }
    return null;
  }
}
