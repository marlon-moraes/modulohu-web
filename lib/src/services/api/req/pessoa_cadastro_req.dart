// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/pessoa_cadastro.dart';
import 'package:modulohu_web/src/models/pessoa_cadastro_crud.dart';
import 'package:modulohu_web/src/models/telefone.dart';
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

Future<PessoaCadastro> reqValidarPessoaCpf(String cpf, BuildContext context) async {
  final headers = {..._defaultHeaders, 'cpf': cpf};
  http.Response? response = await Requisition(ApiRoutes.validarPessoaCpf).req(HttpRequests.GET, json, context, header: headers);
  if (response != null) {
    try {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (body['sucesso']) {
        Message(body['mensagem'], true).inputMsg(context);
        return PessoaCadastro.fromJson(body['pessoa']);
      } else {
        showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(body['mensagem'])));
      }
    } on ApiException catch (e) {
      showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(e.message)));
    } catch (e) {
      Message(e.toString(), false).inputMsg(context);
    }
  }
  return PessoaCadastro();
}

Future<String> reqCarregarTelefonePessoa(String pessoa, BuildContext context) async {
  final headers = {..._defaultHeaders, 'pessoa': pessoa};
  http.Response? response = await Requisition(ApiRoutes.carregarTelefonePessoa).req(HttpRequests.GET, json, context, header: headers);
  if (response != null) {
    try {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (body['sucesso']) {
        Message(body['mensagem'], true).inputMsg(context);
        var res = Telefone.fromJson(body['telefonePessoa']);
        if (res.numero!.length == 8) {
          return '(${res.ddd})${res.numero!.substring(0, 4)}-${res.numero!.substring(4)}';
        } else {
          return '(${res.ddd})${res.numero!.substring(0, 5)}-${res.numero!.substring(5)}';
        }
      } else {
        showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(body['mensagem'])));
      }
    } on ApiException catch (e) {
      showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(e.message)));
    } catch (e) {
      Message(e.toString(), false).inputMsg(context);
    }
  }
  return '';
}

Future<List<PessoaCadastro>> reqListarPessoa(String nome, String cpf, bool prestador, BuildContext context) async {
  Map<String, dynamic> json = {'nome': nome, 'cpf': cpf, 'prestador': prestador};
  http.Response? response = await Requisition(ApiRoutes.listarPessoa).req(HttpRequests.POST, json, context, header: _defaultHeaders);
  if (response != null) {
    try {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (body['sucesso']) {
        return (body['pessoas'] as List).map((e) => PessoaCadastro.fromJson(e)).toList();
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

Future<PessoaCadastro> reqIncluirPessoa(PessoaCadastroCRUD filtro, BuildContext context) async {
  Map<String, dynamic> json = {'pessoa': filtro.toJson()};
  http.Response? response = await Requisition(ApiRoutes.incluirPessoa).req(HttpRequests.POST, json, context, header: _defaultHeaders);
  if (response != null) {
    try {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (body['sucesso']) {
        Message(body['mensagem'], true).inputMsg(context);
        return PessoaCadastro.fromJson(body['pessoa']);
      } else {
        showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(body['mensagem'])));
      }
    } on ApiException catch (e) {
      showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(e.message)));
    } catch (e) {
      Message(e.toString(), false).inputMsg(context);
    }
  }
  return PessoaCadastro();
}
