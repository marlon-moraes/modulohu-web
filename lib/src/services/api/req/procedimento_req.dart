// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/agenda_medica.dart';
import 'package:modulohu_web/src/models/procedimento_agenda_medica.dart';
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

Future<ProcedimentoAgendaMedica> reqIncluirProcedimento(
  AgendaMedica agendaMedica,
  ProcedimentoAgendaMedica procedimentoAgendaMedica,
  BuildContext context,
) async {
  Map<String, dynamic> json = {'agendaMedicaBody': agendaMedica.toJson(), 'procedimentoAgendaMedicaBody': procedimentoAgendaMedica.toJson()};
  http.Response? response = await Requisition(ApiRoutes.incluirProcedimento).req(HttpRequests.POST, json, context, header: _defaultHeaders);
  if (response != null) {
    try {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (body['sucesso']) {
        Message(body['mensagem'], true).inputMsg(context);
        return ProcedimentoAgendaMedica.fromJson(body['procedimentoAgendaMedica']);
      } else {
        showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(body['mensagem'])));
      }
    } on ApiException catch (e) {
      showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(e.message)));
    } catch (e) {
      Message(e.toString(), false).inputMsg(context);
    }
  }
  return ProcedimentoAgendaMedica();
}

Future<List<ProcedimentoAgendaMedica>> reqListarProcedimento(String idAgendaMedica, BuildContext context) async {
  Map<String, dynamic> json = {
    'procedimentoAgendaMedicaSC': {'idAgendaMedica': idAgendaMedica},
  };
  http.Response? response = await Requisition(ApiRoutes.listarProcedimento).req(HttpRequests.POST, json, context, header: _defaultHeaders);
  if (response != null) {
    try {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (body['sucesso']) {
        return (body['procedimentos'] as List).map((e) => ProcedimentoAgendaMedica.fromJson(e)).toList();
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

Future<void> reqAlterarProcedimento(ProcedimentoAgendaMedica filtro, BuildContext context) async {
  Map<String, dynamic> json = {'procedimentoAgendaMedica': filtro.toJson()};
  http.Response? response = await Requisition(ApiRoutes.alterarProcedimento).req(HttpRequests.PUT, json, context, header: _defaultHeaders);
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

Future<void> reqExcluirProcedimento(String id, BuildContext context) async {
  final headers = {..._defaultHeaders, 'id': id};
  Map<String, dynamic> json = {};
  http.Response? response = await Requisition(ApiRoutes.excluirProcedimento).req(HttpRequests.DELETE, json, context, header: headers);
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
