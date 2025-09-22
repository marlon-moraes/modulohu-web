// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/atendimento.dart';
import 'package:modulohu_web/src/models/atendimento_sc.dart';
import 'package:modulohu_web/src/models/crud_atendimento.dart';
import 'package:modulohu_web/src/services/api/req_serv.dart';
import 'package:modulohu_web/src/services/router/api_routes.dart';
import 'package:modulohu_web/src/utils/api_exception.dart';
import 'package:modulohu_web/src/utils/constants.dart';

class AtendimentoReq {
  Map<String, String> get _defaultHeaders => {
    'accept': '*/*',
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Credentials': 'true',
    'Access-Control-Allow-Methods': 'GET, PUT, POST, DELETE',
  };

  Future<Atendimento> reqIncluirAtendimento(CRUDAtendimento filtro, BuildContext context) async {
    Map<String, dynamic> json = {'createData': filtro.toJson()};
    http.Response? response = await Requisition(ApiRoutes.incluirAtendimento).req(HttpRequests.POST, json, context, header: _defaultHeaders);
    if (response != null) {
      try {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        showDialog(context: context, builder: (_) => Alert(success: body['sucesso'], isModal: false, child: Text(body['mensagem'])));
        if (body['sucesso']) return Atendimento.fromJson(body['atendimento']);
      } on ApiException catch (e) {
        showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(e.message)));
      } catch (e) {
        Message(e.toString(), false).inputMsg(context);
      }
    }
    return Atendimento();
  }

  Future<List<Atendimento>> reqListarAtendimento(AtendimentoSC filtro, bool isCarregar, BuildContext context) async {
    Map<String, dynamic> json = {'atendimentoSC': filtro.toJson()};
    http.Response? response = await Requisition(ApiRoutes.listarAtendimento).req(HttpRequests.POST, json, context, header: _defaultHeaders);
    if (response != null) {
      try {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['sucesso']) {
          if (isCarregar) Message(body['mensagem'], true).inputMsg(context);
          return (body['atendimentos'] as List).map((e) => Atendimento.fromJson(e)).toList();
        }
      } on ApiException catch (e) {
        showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(e.message)));
      } catch (e) {
        Message(e.toString(), false).inputMsg(context);
      }
    }
    return [];
  }

  Future<Atendimento> reqAlterarAtendimento(CRUDAtendimento filtro, BuildContext context) async {
    Map<String, dynamic> json = {'updateData': filtro.toJson()};
    http.Response? response = await Requisition(ApiRoutes.alterarAtendimento).req(HttpRequests.PUT, json, context, header: _defaultHeaders);
    if (response != null) {
      try {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['sucesso']) {
          Message(body['mensagem'], true).inputMsg(context);
          return Atendimento.fromJson(body['atendimento']);
        } else {
          showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(body['mensagem'])));
        }
      } on ApiException catch (e) {
        showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(e.message)));
      } catch (e) {
        Message(e.toString(), false).inputMsg(context);
      }
    }
    return Atendimento();
  }

  Future<bool> reqCancelarAtendimento(String id, BuildContext context) async {
    final headers = {..._defaultHeaders, 'id': id};
    Map<String, dynamic> json = {};
    http.Response? response = await Requisition(ApiRoutes.cancelarAtendimento).req(HttpRequests.PUT, json, context, header: headers);
    if (response != null) {
      try {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['sucesso']) {
          Message(body['mensagem'], true).inputMsg(context);
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

  Future<bool> reqFinalizarAtendimento(String id, BuildContext context) async {
    final headers = {..._defaultHeaders, 'id': id};
    Map<String, dynamic> json = {};
    http.Response? response = await Requisition(ApiRoutes.finalizarAtendimento).req(HttpRequests.PUT, json, context, header: headers);
    if (response != null) {
      try {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['sucesso']) {
          Message(body['mensagem'], true).inputMsg(context);
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

  Future<Atendimento> reqReabrirAtendimento(String id, BuildContext context) async {
    final headers = {..._defaultHeaders, 'id': id};
    Map<String, dynamic> json = {};
    http.Response? response = await Requisition(ApiRoutes.reabrirAtendimento).req(HttpRequests.PUT, json, context, header: headers);
    if (response != null) {
      try {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['sucesso']) {
          Message(body['mensagem'], true).inputMsg(context);
          return Atendimento.fromJson(body['atendimento']);
        } else {
          showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(body['mensagem'])));
        }
      } on ApiException catch (e) {
        showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(e.message)));
      } catch (e) {
        Message(e.toString(), false).inputMsg(context);
      }
    }
    return Atendimento();
  }
}
