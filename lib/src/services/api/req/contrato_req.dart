// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:components/components.dart';
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:modulohu_web/src/models/cobertura.dart';
import 'package:modulohu_web/src/models/contrato.dart';
import 'package:modulohu_web/src/models/modulo_beneficiario.dart';
import 'package:modulohu_web/src/services/api/req_serv.dart';
import 'package:modulohu_web/src/services/router/api_routes.dart';
import 'package:modulohu_web/src/utils/api_exception.dart';
import 'package:modulohu_web/src/utils/constants.dart';

class ContratoReq {
  Map<String, String> get _defaultHeaders => {
    'accept': '*/*',
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Credentials': 'true',
    'Access-Control-Allow-Methods': 'GET, PUT, POST, DELETE',
  };

  Future<Contrato> reqListarInformacoesContrato(String contrato, BuildContext context) async {
    final headers = {..._defaultHeaders, 'contrato': contrato};
    Map<String, dynamic> json = {};
    http.Response? response = await Requisition(ApiRoutes.carregarInformacoesContrato).req(HttpRequests.POST, json, context, header: headers);
    if (response != null) {
      try {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['sucesso']) {
          return Contrato.fromJson(body['contratoVO']);
        } else {
          showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(body['mensagem'])));
        }
      } on ApiException catch (e) {
        showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(e.message)));
      } catch (e) {
        Message(e.toString(), false).inputMsg(context);
      }
    }
    return Contrato();
  }

  Future<List<Cobertura>> reqListarCoberturas(int contrato, int beneficiario, BuildContext context) async {
    Map<String, dynamic> json = {
      'coberturaSC': {'contrato': contrato, 'beneficiario': beneficiario},
    };
    http.Response? response = await Requisition(ApiRoutes.carregarInformacoesCoberturas).req(HttpRequests.POST, json, context, header: _defaultHeaders);
    if (response != null) {
      try {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['sucesso']) {
          return (body['coberturas'] as List).map((e) => Cobertura.fromJson(e)).toList();
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

  Future<List<ModuloBeneficiario>> reqListarModulosBeneficiario(String carteirinha, BuildContext context) async {
    final headers = {..._defaultHeaders, 'carteirinha': carteirinha};
    Map<String, dynamic> json = {};
    http.Response? response = await Requisition(ApiRoutes.carregarInformacoesModuloBeneficiario).req(HttpRequests.POST, json, context, header: headers);
    if (response != null) {
      try {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        if (body['sucesso']) {
          return (body['modulosBeneficiario'] as List).map((e) => ModuloBeneficiario.fromJson(e)).toList();
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
