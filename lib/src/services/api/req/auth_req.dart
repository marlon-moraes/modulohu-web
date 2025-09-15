// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:bcrypt/bcrypt.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/screens/auth/dialog/dialog_trocar_senha.dart';
import 'package:modulohu_web/src/services/api/req_serv.dart';
import 'package:modulohu_web/src/services/router/api_routes.dart';
import 'package:modulohu_web/src/utils/api_exception.dart';
import 'package:modulohu_web/src/utils/constants.dart';
import 'package:modulohu_web/src/utils/shared_pref.dart';

Map<String, String> get _defaultHeaders => {
  'accept': '*/*',
  'Content-Type': 'application/json',
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Credentials': 'true',
  'Access-Control-Allow-Methods': 'GET, PUT, POST, DELETE',
};

final _sharedPref = SharedPref();

Future<bool> reqLogon(String login, String senha, BuildContext context) async {
  Map<String, dynamic> json = {
    'usuarioActionsBody': {'codUsuario': int.tryParse(login), 'senha': BCrypt.hashpw(senha, BCrypt.gensalt()), 'moduloCRM': 'UNIDADE_HOSPITALAR'},
  };
  http.Response? response = await Requisition(ApiRoutes.logon).req(HttpRequests.POST, json, context, header: _defaultHeaders);
  if (response != null) {
    try {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (body['sucesso']) {
        if (body['usuarioActions']['usuario']['forcaNovaSenha'] == 1) {
          showDialog(context: context, builder: (context) => DialogTrocarSenha(userCode: body['usuarioActions']['usuario']['codigo'].toString()));
        } else {
          await _sharedPref.save('pessoaLogada', jsonEncode(body));
          context.go('/home/listagem');
        }
        return true;
      }
    } on ApiException catch (e) {
      showDialog(context: context, builder: (_) => Alert(success: false, isModal: false, child: Text(e.message)));
    } catch (e) {
      Message(e.toString(), false).inputMsg(context);
    }
  }
  return false;
}

Future<bool> reqAlterarSenha(String login, String senha, BuildContext context) async {
  Map<String, dynamic> json = {
    'usuarioActionsUpdate': {'codUsuario': int.tryParse(login), 'novaSenha': senha},
  };
  http.Response? response = await Requisition(ApiRoutes.alterarSenha).req(HttpRequests.POST, json, context, header: _defaultHeaders);
  if (response != null) {
    try {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (body['sucesso']) {
        await showDialog(context: context, builder: (_) => Alert(success: true, isModal: false, child: Text(body['mensagem'])));
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
