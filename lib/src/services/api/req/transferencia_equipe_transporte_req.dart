// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/cadastros_transferencia_res.dart';
import 'package:modulohu_web/src/models/crud_cadastro.dart';
import 'package:modulohu_web/src/services/api/req_serv.dart';
import 'package:modulohu_web/src/services/router/api_routes.dart';
import 'package:modulohu_web/src/utils/api_exception.dart';
import 'package:modulohu_web/src/utils/constants.dart';

Map<String, String> get _defaultHeaders => {
  'accept': '*/*',
  'Content-Type': 'application/json',
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Credentials': 'true',
  'Access-Control-Allow-Methods': 'GET, PUT, POST, DELETE',
};

Future<void> reqIncluirEquipeTransporte(CRUDCadastro filtro, BuildContext context) async {
  Map<String, dynamic> json = {'equipeTransporteTransfBody': filtro.toJson()};
  http.Response? response = await Requisition(ApiRoutes.incluirEquipeTransporte).req(HttpRequests.POST, json, context, header: _defaultHeaders);
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

Future<List<CadastrosTransferenciaRes>> reqListarEquipeTransporte(BuildContext context) async {
  Map<String, dynamic> json = {};
  http.Response? response = await Requisition(ApiRoutes.listarEquipeTransporte).req(HttpRequests.POST, json, context, header: _defaultHeaders);
  if (response != null) {
    try {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (body['sucesso']) {
        return (body['equipes'] as List).map((e) => CadastrosTransferenciaRes.fromJson(e)).toList();
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

Future<void> reqAlterarEquipeTransporte(CRUDCadastro filtro, String id, BuildContext context) async {
  Map<String, dynamic> json = {'equipeTransporteTransfBody': filtro.toJson(), 'id': id};
  http.Response? response = await Requisition(ApiRoutes.alterarEquipeTransporte).req(HttpRequests.PUT, json, context, header: _defaultHeaders);
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

Future<void> reqExcluirEquipeTransporte(String id, BuildContext context) async {
  final headers = {..._defaultHeaders, 'id': id};
  Map<String, dynamic> json = {};
  http.Response? response = await Requisition(ApiRoutes.excluirEquipeTransporte).req(HttpRequests.DELETE, json, context, header: headers);
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
