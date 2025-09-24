// ignore_for_file: use_build_context_synchronously, avoid_web_libraries_in_flutter

// 🎯 Dart imports:
import 'dart:convert';
import 'dart:js_interop';
import 'dart:typed_data';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:components/components.dart';
import 'package:http/http.dart' as http;
import 'package:web/web.dart' as web;

// 🌎 Project imports:
import 'package:modulohu_web/src/models/anexo.dart';
import 'package:modulohu_web/src/models/crud_anexo.dart';
import 'package:modulohu_web/src/services/api/req_serv.dart';
import 'package:modulohu_web/src/services/router/api_routes.dart';
import 'package:modulohu_web/src/utils/api_exception.dart';
import 'package:modulohu_web/src/utils/constants.dart';

class AnexoReq {
  Map<String, String> get _defaultHeaders => {
    'accept': '*/*',
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Credentials': 'true',
    'Access-Control-Allow-Methods': 'GET, PUT, POST, DELETE',
  };

  Future<void> reqIncluirAnexo(CRUDAnexo filtro, BuildContext context) async {
    Map<String, dynamic> json = filtro.toJson();
    http.Response? response = await Requisition(ApiRoutes.incluirAnexo).req(HttpRequests.POST, json, context, header: _defaultHeaders);
    if (response != null) {
      try {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['sucesso']) {
          Message(body['mensagem'], true).inputMsg(context);
        } else {
          showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(body['mensagem'])));
        }
      } on ApiException catch (e) {
        showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(e.message)));
      } catch (e) {
        Message(e.toString(), false).inputMsg(context);
      }
    }
  }

  Future<List<Anexo>> reqListarAnexo(String idAtendimentoCRA, BuildContext context) async {
    Map<String, dynamic> json = {
      'anexoAtdCRASC': {'idAtendimentoCRA': idAtendimentoCRA},
    };
    http.Response? response = await Requisition(ApiRoutes.listarAnexo).req(HttpRequests.POST, json, context, header: _defaultHeaders);
    if (response != null) {
      try {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['sucesso']) {
          return (body['anexos'] as List).map((e) => Anexo.fromJson(e)).toList();
        } else {
          showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(body['mensagem'])));
        }
      } on ApiException catch (e) {
        showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(e.message)));
      } catch (e) {
        Message(e.toString(), false).inputMsg(context);
      }
    }
    return [];
  }

  Future<void> reqCarregarAnexo(String id, BuildContext context) async {
    final headers = {..._defaultHeaders, 'id': id};
    Map<String, dynamic> json = {};
    http.Response? response = await Requisition(ApiRoutes.carregarAnexo).req(HttpRequests.GET, json, context, header: headers);
    if (response != null) {
      try {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['sucesso']) {
          Message(body['mensagem'], true).inputMsg(context);
          Uint8List imageBytes = base64Decode(body['arquivo']['arquivoByte64']);
          final blob = web.Blob(
            [imageBytes.toJS].toJS,
            web.BlobPropertyBag(
              type:
                  body['arquivo']['nmArquivo'].contains('.pdf')
                      ? 'application/pdf'
                      : body['arquivo']['nmArquivo'].contains('.png')
                      ? 'image/png'
                      : body['arquivo']['nmArquivo'].contains('.jpg')
                      ? 'image/jpg'
                      : body['arquivo']['nmArquivo'].contains('.jpeg')
                      ? 'image/jpeg'
                      : body['arquivo']['nmArquivo'].contains('.gif')
                      ? 'image/gif'
                      : body['arquivo']['nmArquivo'].contains('.docx')
                      ? 'application/msword'
                      : '',
            ),
          );
          final url = web.URL.createObjectURL(blob);
          web.window.open(url, '_blank');
          web.URL.revokeObjectURL(url);
        } else {
          showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(body['mensagem'])));
        }
      } on ApiException catch (e) {
        showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(e.message)));
      } catch (e) {
        Message(e.toString(), false).inputMsg(context);
      }
    }
  }

  Future<void> reqExcluirAnexo(String idAnexoAtdCRA, String idUsuAlt, BuildContext context) async {
    Map<String, dynamic> json = {'idAnexoAtdCRA': idAnexoAtdCRA, 'idUsuAlt': idUsuAlt};
    http.Response? response = await Requisition(ApiRoutes.excluirAnexo).req(HttpRequests.DELETE, json, context, header: _defaultHeaders);
    if (response != null) {
      try {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['sucesso']) {
          Message(body['mensagem'], true).inputMsg(context);
        } else {
          showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(body['mensagem'])));
        }
      } on ApiException catch (e) {
        showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(e.message)));
      } catch (e) {
        Message(e.toString(), false).inputMsg(context);
      }
    }
  }
}
