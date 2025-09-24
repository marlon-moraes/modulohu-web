// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:components/components.dart';
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:modulohu_web/src/models/crud_cadastro.dart';
import 'package:modulohu_web/src/models/status.dart';
import 'package:modulohu_web/src/services/api/req_serv.dart';
import 'package:modulohu_web/src/services/router/api_routes.dart';
import 'package:modulohu_web/src/utils/api_exception.dart';
import 'package:modulohu_web/src/utils/constants.dart';

class StatusReq {
  Map<String, String> get _defaultHeaders => {
    'accept': '*/*',
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Credentials': 'true',
    'Access-Control-Allow-Methods': 'GET, PUT, POST, DELETE',
  };

  Future<void> reqIncluirStatus(CRUDCadastro filtro, BuildContext context) async {
    Map<String, dynamic> json = {'statusBody': filtro.toJson()};
    http.Response? response = await Requisition(ApiRoutes.incluirStatus).req(HttpRequests.POST, json, context, header: _defaultHeaders);
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

  Future<List<Status>> reqListarStatus(bool ativo, bool fixo, BuildContext context) async {
    Map<String, dynamic> json = {
      'statusSC': {'ativo': ativo, 'fixo': fixo},
    };
    http.Response? response = await Requisition(ApiRoutes.listarStatus).req(HttpRequests.POST, json, context, header: _defaultHeaders);
    if (response != null) {
      try {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['sucesso']) {
          return (body['statusList'] as List).map((e) => Status.fromJson(e)).toList();
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

  Future<void> reqAlterarStatus(CRUDCadastro filtro, BuildContext context) async {
    Map<String, dynamic> json = {'status': filtro.toJson()};
    http.Response? response = await Requisition(ApiRoutes.alterarStatus).req(HttpRequests.PUT, json, context, header: _defaultHeaders);
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

  Future<void> reqExcluirStatus(String id, BuildContext context) async {
    final headers = {..._defaultHeaders, 'id': id};
    Map<String, dynamic> json = {};
    http.Response? response = await Requisition(ApiRoutes.excluirStatus).req(HttpRequests.DELETE, json, context, header: headers);
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
