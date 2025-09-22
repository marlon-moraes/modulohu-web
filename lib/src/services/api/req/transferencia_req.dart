// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/transferencia.dart';
import 'package:modulohu_web/src/services/api/req_serv.dart';
import 'package:modulohu_web/src/services/router/api_routes.dart';
import 'package:modulohu_web/src/utils/api_exception.dart';
import 'package:modulohu_web/src/utils/constants.dart';

class TransferenciaReq {
  Map<String, String> get _defaultHeaders => {
    'accept': '*/*',
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Credentials': 'true',
    'Access-Control-Allow-Methods': 'GET, PUT, POST, DELETE',
  };

  Future<bool> reqIncluirTransferencia(Transferencia transferencia, BuildContext context) async {
    Map<String, dynamic> json = {'transferenciaBody': transferencia.toJson()};
    http.Response? response = await Requisition(ApiRoutes.incluirTransferencia).req(HttpRequests.POST, json, context, header: _defaultHeaders);
    if (response != null) {
      try {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['sucesso']) {
          // Message(body['mensagem'], true).inputMsg(context);
          showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(body['mensagem'])));
          return true;
        } else {
          showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(body['mensagem'])));
        }
      } on ApiException catch (e) {
        showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(e.message)));
      } catch (e) {
        Message(e.toString(), false).inputMsg(context);
      }
    }
    return false;
  }
}
