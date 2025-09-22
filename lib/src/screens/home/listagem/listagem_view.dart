// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/user_action.dart';
import 'package:modulohu_web/src/screens/home/listagem/listagem_widget.dart';
import 'package:modulohu_web/src/screens/home/side_menu.dart';
import 'package:modulohu_web/src/utils/constants.dart';
import 'package:modulohu_web/src/utils/login_validation.dart';
import 'package:modulohu_web/src/utils/shared_pref.dart';

class ListagemView extends StatefulWidget {
  const ListagemView({super.key});

  @override
  State<ListagemView> createState() => _ListagemViewState();
}

class _ListagemViewState extends State<ListagemView> {
  final scrollController = ScrollController();
  final _sharedPref = SharedPref();
  Timer? _dadosTimer;
  var pessoaLogada = UserAction();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size(double.infinity, 57), child: Header(isAuth: false, title: pessoaLogada.usuario?.nome)),
      drawer: SideMenu(pessoaLogada: pessoaLogada, tela: Telas.LISTAGEM),
      body: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        radius: Radius.zero,
        interactive: true,
        child: SingleChildScrollView(controller: scrollController, child: ListagemWidget(pessoaLogada: pessoaLogada)),
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    _dadosTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    if (await validarLogin()) {
      final retorno = await _sharedPref.read('pessoaLogada') ?? '{}';
      setState(() => pessoaLogada = UserAction.fromJson(jsonDecode(retorno)['usuarioActions']));
    } else {
      context.replace('/');
    }
  }
}
