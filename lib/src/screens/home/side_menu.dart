// ignore_for_file: use_build_context_synchronously

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:modulohu_web/environment.dart' as env;
import 'package:modulohu_web/src/models/user_action.dart';
import 'package:modulohu_web/src/screens/home/dialog/dialog_cadastro.dart';
import 'package:modulohu_web/src/services/api/req/assunto_req.dart';
import 'package:modulohu_web/src/services/api/req/canal_req.dart';
import 'package:modulohu_web/src/services/api/req/carater_atendimento_req.dart';
import 'package:modulohu_web/src/services/api/req/status_req.dart';
import 'package:modulohu_web/src/services/api/req/tipo_atendimento_req.dart';
import 'package:modulohu_web/src/utils/constants.dart';
import 'package:modulohu_web/src/utils/shared_pref.dart';

class SideMenu extends StatefulWidget {
  final UserAction pessoaLogada;
  final Telas tela;

  const SideMenu({super.key, required this.pessoaLogada, required this.tela});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final _sharedPref = SharedPref();
  var expanded = false;
  AssuntoReq assuntoReq = AssuntoReq();
  CanalReq canalReq = CanalReq();
  CaraterAtendimentoReq caraterAtendimentoReq = CaraterAtendimentoReq();
  StatusReq statusReq = StatusReq();
  TipoAtendimentoReq tipoAtendimentoReq = TipoAtendimentoReq();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: theme.colorScheme.secondary.withValues(alpha: 0.8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [Image.asset('assets/images/unimed_logo.png', scale: 1.1)]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          env.title,
                          style: TextStyle(
                            fontSize: theme.textTheme.titleSmall!.fontSize,
                            color: theme.colorScheme.onSecondary,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (widget.tela == Telas.ATENDIMENTO)
            ListTile(
              leading: FaIcon(FontAwesomeIcons.tableCells, color: theme.colorScheme.primary),
              title: Text(
                'Listagem',
                style: TextStyle(fontSize: theme.textTheme.bodyLarge!.fontSize, color: theme.colorScheme.primary, overflow: TextOverflow.ellipsis),
              ),
              onTap: () async {
                _sharedPref.remove('protocolo');
                await _sharedPref.remove('responsavel');
                await _sharedPref.remove('coberturaContratual');
                await _sharedPref.remove('convenio');
                await _sharedPref.remove('equipeTransporte');
                await _sharedPref.remove('meioTransporte');
                await _sharedPref.remove('motivo');
                await _sharedPref.remove('motivoNaoAtendida');
                await _sharedPref.remove('motivoRejeitado');
                await _sharedPref.remove('motivoSolicitacao');
                await _sharedPref.remove('precaucao');
                await _sharedPref.remove('tipoInternacao');
                context.go('/home/listagem');
              },
            ),
          if (widget.tela == Telas.LISTAGEM)
            ListTile(
              leading: FaIcon(FontAwesomeIcons.filePen, color: theme.colorScheme.primary),
              title: Text(
                'Novo Atendimento',
                style: TextStyle(fontSize: theme.textTheme.bodyLarge!.fontSize, color: theme.colorScheme.primary, overflow: TextOverflow.ellipsis),
              ),
              onTap: () => context.go('/home/atendimento'),
            ),
          ExpansionTile(
            leading: FaIcon(expanded ? FontAwesomeIcons.folderOpen : FontAwesomeIcons.solidFolderClosed, color: theme.colorScheme.primary),
            onExpansionChanged: (value) => setState(() => expanded = value),
            title: Text(
              'Cadastros',
              style: TextStyle(fontSize: theme.textTheme.bodyLarge!.fontSize, color: theme.colorScheme.primary, overflow: TextOverflow.ellipsis),
              maxLines: 3,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.solidFile, color: theme.colorScheme.primary),
                  title: Text(
                    'Tipo de Atendimento',
                    style: TextStyle(fontSize: theme.textTheme.bodyLarge!.fontSize, color: theme.colorScheme.primary, overflow: TextOverflow.ellipsis),
                    maxLines: 3,
                  ),
                  onTap: () async {
                    final res = await tipoAtendimentoReq.reqListarTipoAtendimento(context);
                    showDialog(
                      context: context,
                      builder: (context) => DialogCadastro(title: 'Tipo de Atendimento', list: res, pessoaLogada: widget.pessoaLogada),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.solidFile, color: theme.colorScheme.primary),
                  title: Text(
                    'Assunto',
                    style: TextStyle(fontSize: theme.textTheme.bodyLarge!.fontSize, color: theme.colorScheme.primary, overflow: TextOverflow.ellipsis),
                    maxLines: 3,
                  ),
                  onTap: () async {
                    final res = await assuntoReq.reqListarAssunto(context);
                    showDialog(context: context, builder: (context) => DialogCadastro(title: 'Assunto', list: res, pessoaLogada: widget.pessoaLogada));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.solidFile, color: theme.colorScheme.primary),
                  title: Text(
                    'Canal',
                    style: TextStyle(fontSize: theme.textTheme.bodyLarge!.fontSize, color: theme.colorScheme.primary, overflow: TextOverflow.ellipsis),
                    maxLines: 3,
                  ),
                  onTap: () async {
                    final res = await canalReq.reqListarCanal(context);
                    showDialog(context: context, builder: (context) => DialogCadastro(title: 'Canal', list: res, pessoaLogada: widget.pessoaLogada));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.solidFile, color: theme.colorScheme.primary),
                  title: Text(
                    'Caráter de Atendimento',
                    style: TextStyle(fontSize: theme.textTheme.bodyLarge!.fontSize, color: theme.colorScheme.primary, overflow: TextOverflow.ellipsis),
                    maxLines: 3,
                  ),
                  onTap: () async {
                    final res = await caraterAtendimentoReq.reqListarCaraterAtendimento(context);
                    showDialog(
                      context: context,
                      builder: (context) => DialogCadastro(title: 'Caráter de Atendimento', list: res, pessoaLogada: widget.pessoaLogada),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.solidFile, color: theme.colorScheme.primary),
                  title: Text(
                    'Status',
                    style: TextStyle(fontSize: theme.textTheme.bodyLarge!.fontSize, color: theme.colorScheme.primary, overflow: TextOverflow.ellipsis),
                    maxLines: 3,
                  ),
                  onTap: () async {
                    final res = await statusReq.reqListarStatus(true, false, context);
                    showDialog(context: context, builder: (context) => DialogCadastro(title: 'Status', list: res, pessoaLogada: widget.pessoaLogada));
                  },
                ),
              ),
            ],
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.solidFileLines, color: Colors.grey),
            title: Text(
              'Gerar Relatório',
              style: TextStyle(fontSize: theme.textTheme.bodyLarge!.fontSize, color: Colors.grey, overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}
