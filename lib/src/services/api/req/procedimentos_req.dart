// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:components/components.dart';
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:modulohu_web/src/models/procedimento.dart';
import 'package:modulohu_web/src/services/api/req_serv.dart';
import 'package:modulohu_web/src/services/router/api_routes.dart';
import 'package:modulohu_web/src/utils/api_exception.dart';
import 'package:modulohu_web/src/utils/constants.dart';

class ProcedimentosReq {
  Map<String, String> get _defaultHeaders => {
    'accept': '*/*',
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Credentials': 'true',
    'Access-Control-Allow-Methods': 'GET, PUT, POST, DELETE',
  };

  Future<List<Procedimento>> reqListarProcedimentos(String nome, BuildContext context) async {
    Map<String, dynamic> json = {
      'procedimentoSC': {'nome': nome},
    };
    http.Response? response = await Requisition(ApiRoutes.listarProcedimentos).req(HttpRequests.POST, json, context, header: _defaultHeaders);
    if (response != null) {
      try {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['sucesso']) {
          return (body['procedimentos'] as List).map((e) => Procedimento.fromJson(e)).toList();
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
}
