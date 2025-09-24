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
import 'package:modulohu_web/src/models/anexo.dart';
import 'package:modulohu_web/src/models/atendimento.dart';
import 'package:modulohu_web/src/models/atendimento_sc.dart';
import 'package:modulohu_web/src/models/crud_atendimento.dart';
import 'package:modulohu_web/src/models/crud_evento.dart';
import 'package:modulohu_web/src/models/evento.dart';
import 'package:modulohu_web/src/models/procedimento_agenda_medica.dart';
import 'package:modulohu_web/src/models/user_action.dart';
import 'package:modulohu_web/src/screens/home/atendimento/abas/agenda_medica/agenda_medica_tab.dart';
import 'package:modulohu_web/src/screens/home/atendimento/abas/atendimento/abas/anexos_tab.dart';
import 'package:modulohu_web/src/screens/home/atendimento/abas/atendimento/abas/eventos_tab.dart';
import 'package:modulohu_web/src/screens/home/atendimento/abas/atendimento/atendimento_widget.dart';
import 'package:modulohu_web/src/screens/home/atendimento/abas/informacoes_contratuais/informacoes_contratuais_tab.dart';
import 'package:modulohu_web/src/screens/home/atendimento/abas/transferencia/transferencia_tab_new.dart';
import 'package:modulohu_web/src/screens/home/dialog/dialog_listagem.dart';
import 'package:modulohu_web/src/screens/home/side_menu.dart';
import 'package:modulohu_web/src/services/api/req/assunto_req.dart';
import 'package:modulohu_web/src/services/api/req/atendimento_req.dart';
import 'package:modulohu_web/src/services/api/req/canal_req.dart';
import 'package:modulohu_web/src/services/api/req/carater_atendimento_req.dart';
import 'package:modulohu_web/src/services/api/req/evento_req.dart';
import 'package:modulohu_web/src/services/api/req/responsavel_req.dart';
import 'package:modulohu_web/src/services/api/req/status_req.dart';
import 'package:modulohu_web/src/services/api/req/tipo_atendimento_req.dart';
import 'package:modulohu_web/src/themes/theme.dart';
import 'package:modulohu_web/src/utils/constants.dart';
import 'package:modulohu_web/src/utils/shared_pref.dart';
import 'package:modulohu_web/src/utils/utils.dart';

class AtendimentoView extends StatefulWidget {
  const AtendimentoView({super.key});

  @override
  State<AtendimentoView> createState() => _AtendimentoViewState();
}

class _AtendimentoViewState extends State<AtendimentoView> with TickerProviderStateMixin {
  final _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final _sharedPref = SharedPref();
  Timer? _dadosTimer;
  var pessoaLogada = UserAction();
  final protocoloController = TextEditingController();
  final idStatusController = TextEditingController();
  final nomeStatusController = TextEditingController();
  final dtSolicitacaoController = TextEditingController();
  final dtSolicitacaoFocus = FocusNode();
  final idBeneficiarioController = TextEditingController();
  final codBeneficiarioController = TextEditingController();
  final nomeBeneficiarioController = TextEditingController();
  final contratoBeneficiarioController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final idMedSolController = TextEditingController();
  final nomeMedSolController = TextEditingController();
  final idResponsavelController = TextEditingController();
  final nomeResponsavelController = TextEditingController();
  final idTipoAtendimentoController = TextEditingController();
  final nomeTipoAtendimentoController = TextEditingController();
  final idAssuntoController = TextEditingController();
  final nomeAssuntoController = TextEditingController();
  final idCanalController = TextEditingController();
  final nomeCanalController = TextEditingController();
  final idCaraterAtendimentoController = TextEditingController();
  final nomeCaraterAtendimentoController = TextEditingController();
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  var barraCarregamento = false;
  var isModoInclusao = true;
  var isCanceladoFinalizado = false;
  var atendimentoCarregado = Atendimento();
  List<Evento> eventos = [];
  List<Anexo> anexos = [];
  List<ProcedimentoAgendaMedica> procedimentos = [];
  var eventoCarregado = Evento();
  var inclusaoEvento = false;
  var alteracaoEvento = false;
  var agendaMedica = false;
  var transferencia = false;
  var contrato = false;
  var carregandoBeneficiario = false;
  AtendimentoReq atendimentoReq = AtendimentoReq();
  AssuntoReq assuntoReq = AssuntoReq();
  CanalReq canalReq = CanalReq();
  CaraterAtendimentoReq caraterAtendimentoReq = CaraterAtendimentoReq();
  EventoReq eventoReq = EventoReq();
  ResponsavelReq responsavelReq = ResponsavelReq();
  StatusReq statusReq = StatusReq();
  TipoAtendimentoReq tipoAtendimentoReq = TipoAtendimentoReq();
  Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    var filtroAtendimento = CRUDAtendimento();
    var filtroEvento = CRUDEvento();

    final List<Tab> tabs = [
      Tab(text: 'Atendimento'),
      if (agendaMedica) Tab(text: 'Agenda Médica'),
      if (transferencia) Tab(text: 'Transferência'),
      if (contrato) Tab(text: 'Informações Contratuais'),
    ];

    Future<void> carregarAtendimento() async {
      if (!barraCarregamento && protocoloController.text.isNotEmpty) {
        _mostrarBarraCarregamento();
        var filtro = AtendimentoSC();
        filtro.protocolo = protocoloController.text;
        final res = await atendimentoReq.reqListarAtendimento(filtro, true, context);
        setState(() => atendimentoCarregado = res.first);
        _popularCampos();
        _mostrarBarraCarregamento();
      }
    }

    Future<void> incluirAtendimento() async {
      if (!barraCarregamento) {
        _formKey.currentState!.save();
        _mostrarBarraCarregamento();
        filtroAtendimento.idEmp = pessoaLogada.usuario?.empresa?.id;
        filtroAtendimento.idUni = pessoaLogada.unidades?.first.idUni;
        filtroAtendimento.idUsuInc = pessoaLogada.usuario?.id;
        filtroAtendimento.idUsuAlt = pessoaLogada.usuario?.id;
        var res = await atendimentoReq.reqIncluirAtendimento(filtroAtendimento, context);
        if (res.protocolo != null) {
          atendimentoCarregado = res;
          _popularCampos();
        }
        _mostrarBarraCarregamento();
      }
    }

    Future<void> alterarAtendimento() async {
      if (!barraCarregamento) {
        _formKey.currentState!.save();
        _mostrarBarraCarregamento();
        filtroAtendimento.idEmp = pessoaLogada.usuario?.empresa?.id;
        filtroAtendimento.idUni = pessoaLogada.unidades?.first.idUni;
        filtroAtendimento.idUsuInc = pessoaLogada.usuario?.id;
        filtroAtendimento.idUsuAlt = pessoaLogada.usuario?.id;
        filtroAtendimento.id = atendimentoCarregado.id;
        var res = await atendimentoReq.reqAlterarAtendimento(filtroAtendimento, context);
        if (res.protocolo != null) {
          atendimentoCarregado = res;
          _popularCampos();
        }
        _carregarEventos();
        _mostrarBarraCarregamento();
      }
    }

    Future<void> cancelarAtendimento() async {
      if (!barraCarregamento) {
        bool confirmation = false;
        await showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: Text('Tem certeza que deseja cancelar o Atendimento?'),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      onPressed: () {
                        confirmation = true;
                        Navigator.of(context).pop();
                      },
                      buttonColor: Colors.red,
                      margin: EdgeInsets.all(8),
                      text: 'SIM',
                    ),
                    Button(onPressed: () => Navigator.of(context).pop(), buttonColor: Colors.orange, margin: EdgeInsets.all(8), text: 'NÃO'),
                  ],
                ),
              ],
            );
          },
        );
        if (confirmation) {
          _formKey.currentState!.save();
          _mostrarBarraCarregamento();
          var res = await atendimentoReq.reqCancelarAtendimento(atendimentoCarregado.id ?? '', context);
          if (res) {
            setState(() => isCanceladoFinalizado = true);
            nomeStatusController.text = 'CANCELADO';
          }
          _mostrarBarraCarregamento();
          context.go('/home/listagem');
        }
      }
    }

    Future<void> finalizarAtendimento() async {
      if (!barraCarregamento) {
        bool confirmation = false;
        await showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: Text('Tem certeza que deseja finalizar o Atendimento?'),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      onPressed: () {
                        confirmation = true;
                        Navigator.of(context).pop();
                      },
                      buttonColor: Colors.red,
                      margin: EdgeInsets.all(8),
                      text: 'SIM',
                    ),
                    Button(onPressed: () => Navigator.of(context).pop(), buttonColor: Colors.orange, margin: EdgeInsets.all(8), text: 'NÃO'),
                  ],
                ),
              ],
            );
          },
        );
        if (confirmation) {
          _formKey.currentState!.save();
          _mostrarBarraCarregamento();
          var res = await atendimentoReq.reqFinalizarAtendimento(atendimentoCarregado.id ?? '', context);
          if (res) {
            setState(() => isCanceladoFinalizado = true);
            nomeStatusController.text = 'FECHADO';
          }
          _mostrarBarraCarregamento();
          context.go('/home/listagem');
        }
      }
    }

    Future<void> reabrirAtendimento() async {
      if (!barraCarregamento) {
        _mostrarBarraCarregamento();
        var res = await atendimentoReq.reqReabrirAtendimento(atendimentoCarregado.id!, context);
        if (res.protocolo != null) {
          atendimentoCarregado = res;
          _popularCampos();
        }
        _mostrarBarraCarregamento();
      }
    }

    Future<void> incluirEvento() async {
      if (!barraCarregamento) {
        _mostrarBarraCarregamento();
        filtroEvento.idEmp = pessoaLogada.usuario?.empresa?.id;
        filtroEvento.idUni = pessoaLogada.unidades?.first.idUni;
        filtroEvento.idAtendimentoCRA = atendimentoCarregado.id;
        filtroEvento.titulo = tituloController.text;
        filtroEvento.descricao = descricaoController.text;
        filtroEvento.usuario = pessoaLogada.usuario?.nome;
        filtroEvento.dtEvento = DateTime.now().toString();
        filtroEvento.idUsuInc = pessoaLogada.usuario?.id;
        filtroEvento.idUsuAlt = pessoaLogada.usuario?.id;
        final res = await eventoReq.reqIncluirEvento(filtroEvento, context);
        if (res) {
          _limparCamposEventos();
          _carregarEventos();
        }
        _mostrarBarraCarregamento();
      }
    }

    Future<void> alterarEvento() async {
      if (!barraCarregamento) {
        _mostrarBarraCarregamento();
        filtroEvento.idEmp = pessoaLogada.usuario?.empresa?.id;
        filtroEvento.idUni = pessoaLogada.unidades?.first.idUni;
        filtroEvento.idAtendimentoCRA = atendimentoCarregado.id;
        filtroEvento.titulo = tituloController.text;
        filtroEvento.descricao = descricaoController.text;
        filtroEvento.usuario = pessoaLogada.usuario?.nome;
        filtroEvento.dtEvento = DateTime.now().toString();
        filtroEvento.id = eventoCarregado.id;
        filtroEvento.codigo = eventoCarregado.codigo;
        filtroEvento.idUsuInc = pessoaLogada.usuario?.id;
        filtroEvento.idUsuAlt = pessoaLogada.usuario?.id;
        await eventoReq.reqAlterarEvento(filtroEvento, context);
        _limparCamposEventos();
        _carregarEventos();
        _mostrarBarraCarregamento();
      }
    }

    Widget protocolo() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              controller: protocoloController,
              text: 'Protocolo',
              enabled: true,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () => carregarAtendimento(),
              child: Ink(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: theme.colorScheme.secondary),
                child: Icon(Icons.arrow_right_alt_rounded, color: theme.colorScheme.onSecondary),
              ),
            ),
          ),
        ],
      );
    }

    Widget status() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              onSaved: (p0) => filtroAtendimento.idStatus = idStatusController.text,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              controller: nomeStatusController,
              enabled: false,
              text: 'Status',
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!isCanceladoFinalizado) {
                  final res = await statusReq.reqListarStatus(true, false, context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogListagem(
                        title: 'Status',
                        list: res,
                        id: idStatusController,
                        cod: TextEditingController(),
                        nome: nomeStatusController,
                        pessoaLogada: pessoaLogada,
                        contrato: TextEditingController(),
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(color: !isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey, borderRadius: BorderRadius.circular(4)),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget dtSolicitacao() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              controller: dtSolicitacaoController,
              inputFormatters: [utils.mascaraDataHora],
              focusNode: dtSolicitacaoFocus,
              text: 'Data Solicitação',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              child: Ink(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.grey),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget beneficiario() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              onSaved: (p0) {
                filtroAtendimento.beneficiarioCarteirinha = int.tryParse(idBeneficiarioController.text);
                filtroAtendimento.beneficiarioCpf = codBeneficiarioController.text;
                filtroAtendimento.beneficiarioNome = p0;
                filtroAtendimento.beneficiarioContrato = contratoBeneficiarioController.text;
              },
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              controller: nomeBeneficiarioController,
              text: 'Beneficiário',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!isCanceladoFinalizado) {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return DialogListagem(
                        title: 'Beneficiário',
                        list: [],
                        id: idBeneficiarioController,
                        cod: codBeneficiarioController,
                        nome: nomeBeneficiarioController,
                        pessoaLogada: pessoaLogada,
                        contrato: contratoBeneficiarioController,
                      );
                    },
                  );
                  if (contratoBeneficiarioController.text.isNotEmpty) {
                    setState(() => contrato = true);
                  } else {
                    setState(() => contrato = false);
                  }
                }
              },
              child: Ink(
                decoration: BoxDecoration(color: !isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey, borderRadius: BorderRadius.circular(4)),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
          if (carregandoBeneficiario)
            Container(margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), child: CircularProgressIndicator(color: Themes.loadingBarColor)),
        ],
      );
    }

    Widget telefone() {
      return Row(
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              onSaved: (p0) => filtroAtendimento.telefone = p0,
              inputFormatters: [utils.mascaraCelular],
              enabled: !isCanceladoFinalizado,
              controller: telefoneController,
              text: 'Telefone',
            ),
          ),
        ],
      );
    }

    Widget email() {
      return Row(
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              onSaved: (p0) => filtroAtendimento.email = p0,
              enabled: !isCanceladoFinalizado,
              controller: emailController,
              text: 'Email',
            ),
          ),
        ],
      );
    }

    Widget medicoSolicitante() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              onSaved: (p0) {
                filtroAtendimento.prestadorAutoid = int.tryParse(idMedSolController.text);
                filtroAtendimento.prestadorNome = p0;
              },
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              controller: nomeMedSolController,
              text: 'Médico Solicitante',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!isCanceladoFinalizado) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogListagem(
                        title: 'Médico Solicitante',
                        list: [],
                        id: idMedSolController,
                        cod: TextEditingController(),
                        nome: nomeMedSolController,
                        pessoaLogada: pessoaLogada,
                        contrato: TextEditingController(),
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(color: !isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey, borderRadius: BorderRadius.circular(4)),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget responsavel() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              onSaved: (p0) => filtroAtendimento.idResponsavel = idResponsavelController.text,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              controller: nomeResponsavelController,
              text: 'Responsável',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!isCanceladoFinalizado) {
                  final res = await responsavelReq.reqListarResponsavel(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogListagem(
                        title: 'Responsável',
                        list: res,
                        id: idResponsavelController,
                        cod: TextEditingController(),
                        nome: nomeResponsavelController,
                        pessoaLogada: pessoaLogada,
                        contrato: TextEditingController(),
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(color: !isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey, borderRadius: BorderRadius.circular(4)),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget tipoAtendimento() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              onSaved: (p0) => filtroAtendimento.idTipo = idTipoAtendimentoController.text,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              controller: nomeTipoAtendimentoController,
              text: 'Tipo Atendimento',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!isCanceladoFinalizado) {
                  final res = await tipoAtendimentoReq.reqListarTipoAtendimento(context);
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return DialogListagem(
                        title: 'Tipo de Atendimento',
                        list: res,
                        id: idTipoAtendimentoController,
                        cod: TextEditingController(),
                        nome: nomeTipoAtendimentoController,
                        pessoaLogada: pessoaLogada,
                        contrato: TextEditingController(),
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(color: !isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey, borderRadius: BorderRadius.circular(4)),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget assunto() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              onSaved: (p0) => filtroAtendimento.idAssunto = idAssuntoController.text,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              controller: nomeAssuntoController,
              text: 'Assunto',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!isCanceladoFinalizado) {
                  final res = await assuntoReq.reqListarAssunto(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogListagem(
                        title: 'Assunto',
                        list: res,
                        id: idAssuntoController,
                        cod: TextEditingController(),
                        nome: nomeAssuntoController,
                        pessoaLogada: pessoaLogada,
                        contrato: TextEditingController(),
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(color: !isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey, borderRadius: BorderRadius.circular(4)),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget canal() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              onSaved: (p0) => filtroAtendimento.idCanal = idCanalController.text,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              controller: nomeCanalController,
              enabled: false,
              text: 'Canal',
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!isCanceladoFinalizado) {
                  final res = await canalReq.reqListarCanal(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogListagem(
                        title: 'Canal',
                        list: res,
                        id: idCanalController,
                        cod: TextEditingController(),
                        nome: nomeCanalController,
                        pessoaLogada: pessoaLogada,
                        contrato: TextEditingController(),
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(color: !isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey, borderRadius: BorderRadius.circular(4)),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget caraterAtendimento() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              onSaved: (p0) => filtroAtendimento.idCarater = idCaraterAtendimentoController.text,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              controller: nomeCaraterAtendimentoController,
              text: 'Caráter de Atendimento',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!isCanceladoFinalizado) {
                  final res = await caraterAtendimentoReq.reqListarCaraterAtendimento(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogListagem(
                        title: 'Caráter de Atendimento',
                        list: res,
                        id: idCaraterAtendimentoController,
                        cod: TextEditingController(),
                        nome: nomeCaraterAtendimentoController,
                        pessoaLogada: pessoaLogada,
                        contrato: TextEditingController(),
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(color: !isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey, borderRadius: BorderRadius.circular(4)),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget titulo() {
      return FormTextField(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        enabled: !isModoInclusao && !isCanceladoFinalizado,
        controller: tituloController,
        text: 'Título',
      );
    }

    Widget descricao() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            labelStyle: theme.textTheme.bodyMedium,
            border: const OutlineInputBorder(),
            labelText: 'Descrição',
            isDense: true,
          ),
          enabled: !isModoInclusao && !isCanceladoFinalizado,
          controller: descricaoController,
          maxLines: 5,
        ),
      );
    }

    Widget buildLargeHeader() {
      return Column(
        children: [
          Row(children: [Expanded(child: protocolo()), Expanded(child: status()), Expanded(child: dtSolicitacao())]),
          Row(children: [Expanded(child: beneficiario()), Expanded(child: telefone()), Expanded(child: email())]),
          Row(
            children: [
              Expanded(child: SizedBox()),
              Expanded(flex: 2, child: medicoSolicitante()),
              Expanded(flex: 2, child: responsavel()),
              Expanded(child: SizedBox()),
            ],
          ),
        ],
      );
    }

    Widget buildSmallHeader() {
      return Column(children: [protocolo(), status(), dtSolicitacao(), beneficiario(), telefone(), email(), medicoSolicitante(), responsavel()]);
    }

    List<Widget> botoesDadosGerais() {
      return [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: InkWell(
            onTap: () => inclusaoEvento && !alteracaoEvento && !isCanceladoFinalizado ? incluirEvento() : null,
            child: Ink(
              decoration: BoxDecoration(
                color: inclusaoEvento && !alteracaoEvento && !isCanceladoFinalizado ? theme.colorScheme.secondary : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(Icons.note_add, color: theme.colorScheme.onSecondary),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: InkWell(
            onTap: () => alteracaoEvento && !inclusaoEvento && !isCanceladoFinalizado ? alterarEvento() : null,
            child: Ink(
              decoration: BoxDecoration(
                color: alteracaoEvento && !inclusaoEvento && !isCanceladoFinalizado ? theme.colorScheme.tertiary : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(Icons.edit_document, color: theme.colorScheme.onTertiary),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: InkWell(
            onTap: () => _limparCamposEventos(),
            child: Ink(
              decoration: BoxDecoration(color: theme.colorScheme.primary, borderRadius: BorderRadius.circular(4)),
              child: Icon(color: theme.colorScheme.onPrimary, Icons.cleaning_services_rounded),
            ),
          ),
        ),
      ];
    }

    Widget tabelaDadosGerais() {
      return Container(
        decoration: BoxDecoration(color: theme.colorScheme.outline, borderRadius: BorderRadius.circular(4)),
        margin: EdgeInsets.fromLTRB(0, 4, 8, 8),
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            PaginatedDataTable(
              showFirstLastButtons: true,
              showCheckboxColumn: false,
              horizontalMargin: 10,
              columnSpacing: 10,
              rowsPerPage: 4,
              columns: [
                DataColumn(label: Expanded(child: Center(child: Text('Título')))),
                DataColumn(label: VerticalDivider()),
                DataColumn(label: Expanded(child: Center(child: Text('Descrição')))),
                DataColumn(label: VerticalDivider()),
                DataColumn(label: Expanded(child: Center(child: Text('Usuário')))),
              ],
              source: AssentamentosDataSource(
                eventos,
                tituloController,
                descricaoController,
                eventoCarregado,
                barraCarregamento,
                _mostrarBarraCarregamento,
                _limparCamposEventos,
                _alterarModoInclusao,
                _alterarModoAlteracao,
                size,
                context,
              ),
            ),
          ],
        ),
      );
    }

    return DefaultTabController(
      length: tabs.length,
      // agendaMedica || transferencia && contrato
      //     ? 3
      //     : agendaMedica || transferencia || contrato
      //     ? 2
      //     : 1,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 114),
          child: Header(
            isAuth: false,
            title: pessoaLogada.usuario?.nome,
            bottom: TabBar(
              tabs: tabs,
              labelStyle: TextStyle(color: theme.colorScheme.onSecondary, fontWeight: FontWeight.bold, fontSize: 16),
              unselectedLabelStyle: TextStyle(color: theme.colorScheme.onSecondary, fontSize: 16),
              indicatorColor: theme.colorScheme.tertiary,
            ),
          ),
        ),
        drawer: SideMenu(pessoaLogada: pessoaLogada, tela: Telas.ATENDIMENTO),
        body: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          trackVisibility: true,
          radius: Radius.zero,
          interactive: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              height: Responsive.isLargeScreen(context) ? 1416 + 88 : 2223 + 262,
              padding: EdgeInsets.fromLTRB(4, 0, 12, 0),
              child: TabBarView(
                children: [
                  //? ATENDIMENTO
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        if (Responsive.isLargeScreen(context)) buildLargeHeader(),
                        if (!Responsive.isLargeScreen(context)) buildSmallHeader(),
                        DefaultTabController(
                          length: 3,
                          child: Container(
                            decoration: BoxDecoration(border: Border.all(color: theme.colorScheme.primary), borderRadius: BorderRadius.circular(4)),
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                TabBar(
                                  labelStyle: TextStyle(color: theme.colorScheme.tertiary, fontWeight: FontWeight.bold, fontSize: 16),
                                  tabs: [Tab(text: 'Dados Gerais'), Tab(text: 'Assentamentos'), Tab(text: 'Anexos')],
                                ),
                                Divider(),
                                SizedBox(
                                  height:
                                      Responsive.isLargeScreen(context)
                                          ? 415
                                          : eventos.isNotEmpty
                                          ? 790
                                          : 407,
                                  child: TabBarView(
                                    children: [
                                      //? DADOS GERAIS
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(height: 2),
                                          if (Responsive.isLargeScreen(context))
                                            Row(children: [Expanded(flex: 2, child: tipoAtendimento()), Expanded(flex: 2, child: assunto())]),
                                          if (Responsive.isLargeScreen(context))
                                            Row(children: [Expanded(flex: 2, child: canal()), Expanded(flex: 2, child: caraterAtendimento())]),
                                          if (!Responsive.isLargeScreen(context))
                                            Column(
                                              children: [
                                                tipoAtendimento(),
                                                assunto(),
                                                canal(),
                                                caraterAtendimento(),
                                                titulo(),
                                                descricao(),
                                                Row(mainAxisAlignment: MainAxisAlignment.center, children: botoesDadosGerais()),
                                                if (eventos.isNotEmpty)
                                                  Container(
                                                    decoration: BoxDecoration(color: theme.colorScheme.outline, borderRadius: BorderRadius.circular(4)),
                                                    width: Responsive.isLargeScreen(context) ? size.width * 0.88 : null,
                                                    child: SizedBox(
                                                      height: 368,
                                                      child: ListView.builder(
                                                        itemCount: eventos.length,
                                                        itemBuilder: (context, index) {
                                                          final item = eventos[index];
                                                          return InkWell(
                                                            onTap: () {
                                                              tituloController.text = item.titulo ?? '';
                                                              descricaoController.text = item.descricao ?? '';
                                                              eventoCarregado.id = item.id;
                                                              eventoCarregado.codigo = item.codigo;
                                                              eventoCarregado.dtInc = item.dtInc;
                                                              eventoCarregado.dtAlt = item.dtAlt;
                                                              _alterarModoAlteracao();
                                                            },
                                                            child: Card(
                                                              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(12),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text('Título', style: const TextStyle(fontWeight: FontWeight.bold)),
                                                                    Text('  ${item.titulo ?? ''}'),
                                                                    const SizedBox(height: 4),
                                                                    Text('Descrição', style: const TextStyle(fontWeight: FontWeight.bold)),
                                                                    Text('  ${item.descricao ?? ''}'),
                                                                    const SizedBox(height: 4),
                                                                    Text('Usuário', style: const TextStyle(fontWeight: FontWeight.bold)),
                                                                    Text('  ${item.usuario ?? ''}'),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          if (Responsive.isLargeScreen(context))
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Row(children: [Expanded(child: titulo())]),
                                                      Row(children: [Expanded(child: descricao())]),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [Column(children: botoesDadosGerais()), Expanded(child: tabelaDadosGerais())],
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                      //? ASSENTAMENTOS
                                      EventosTab(atendimentoCarregado: atendimentoCarregado),
                                      //? ANEXOS
                                      Container(
                                        padding: EdgeInsets.only(bottom: 4),
                                        child: AnexosTab(
                                          pessoaLogada: pessoaLogada,
                                          atendimentoCarregado: atendimentoCarregado,
                                          isModoInclusao: isModoInclusao,
                                          isCanceladoFinalizado: isCanceladoFinalizado,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(margin: EdgeInsets.only(top: 8), child: loadingBar(barraCarregamento)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isModoInclusao && !isCanceladoFinalizado)
                              Button(
                                onPressed: () => isModoInclusao && !isCanceladoFinalizado ? incluirAtendimento() : null,
                                buttonColor: isModoInclusao && !isCanceladoFinalizado ? Colors.green : Colors.grey,
                                margin: EdgeInsets.all(8),
                                text: 'Incluir',
                              ),
                            if (!isModoInclusao && !isCanceladoFinalizado)
                              Button(
                                onPressed: () => !isModoInclusao && !isCanceladoFinalizado ? alterarAtendimento() : null,
                                buttonColor: !isModoInclusao && !isCanceladoFinalizado ? Colors.blueAccent : Colors.grey,
                                margin: EdgeInsets.all(8),
                                text: 'Alterar',
                              ),
                            if (!isModoInclusao && !isCanceladoFinalizado)
                              Button(
                                onPressed: () => !isModoInclusao && !isCanceladoFinalizado ? cancelarAtendimento() : null,
                                buttonColor: !isModoInclusao && !isCanceladoFinalizado ? Colors.orange : Colors.grey,
                                margin: EdgeInsets.all(8),
                                text: 'Cancelar',
                              ),
                            if (!isModoInclusao && !isCanceladoFinalizado)
                              Button(
                                onPressed: () => !isModoInclusao && !isCanceladoFinalizado ? finalizarAtendimento() : null,
                                buttonColor: !isModoInclusao && !isCanceladoFinalizado ? Colors.red : Colors.grey,
                                margin: EdgeInsets.all(8),
                                text: 'Finalizar',
                              ),
                            if (atendimentoCarregado.status?.nome == 'ENCERRADO' || atendimentoCarregado.status?.nome == 'Encerrado')
                              Button(
                                onPressed: () {
                                  if (atendimentoCarregado.status?.nome == 'ENCERRADO' || atendimentoCarregado.status?.nome == 'Encerrado') {
                                    reabrirAtendimento();
                                  }
                                },
                                buttonColor:
                                    atendimentoCarregado.status?.nome == 'ENCERRADO' || atendimentoCarregado.status?.nome == 'Encerrado'
                                        ? Colors.lightBlueAccent
                                        : Colors.grey,
                                margin: EdgeInsets.all(8),
                                text: 'Reabrir',
                              ),
                            if (!Responsive.isSmallScreen(context))
                              Button(onPressed: () => _limparCampos(), buttonColor: Colors.brown, margin: EdgeInsets.all(8), text: 'Limpar'),
                          ],
                        ),
                        if (Responsive.isSmallScreen(context))
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Button(onPressed: () => _limparCampos(), buttonColor: Colors.brown, margin: EdgeInsets.all(8), text: 'Limpar')],
                          ),
                      ],
                    ),
                  ),
                  //? AGENDA MÉDICA
                  if (agendaMedica)
                    AgendaMedicaTab(
                      pessoaLogada: pessoaLogada,
                      idAtendimentoCRA: atendimentoCarregado.id ?? '',
                      atendimentoCarregado: atendimentoCarregado,
                      anexos: anexos,
                      isModoInclusao: isModoInclusao,
                      isCanceladoFinalizado: isCanceladoFinalizado,
                    ),
                  //? TRANSFERÊNCIA
                  if (transferencia)
                    TransferenciaTabNew(
                      pessoaLogada: pessoaLogada,
                      atendimentoCarregado: atendimentoCarregado,
                      isModoInclusao: isModoInclusao,
                      isCanceladoFinalizado: isCanceladoFinalizado,
                      beneficiarioCarteirinha: idBeneficiarioController.text.isNotEmpty ? int.tryParse(idBeneficiarioController.text) : null,
                      beneficiarioNome: nomeBeneficiarioController.text,
                      beneficiarioCnp: codBeneficiarioController.text.replaceAll(RegExp(r'[.\-]'), ''),
                    ),
                  //? INFORMAÇÕES CONTRATUAIS
                  if (contrato) InformacoesContratuaisTab(carteirinha: idBeneficiarioController.text, contrato: contratoBeneficiarioController.text),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const Footer(),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    protocoloController.dispose();
    idStatusController.dispose();
    nomeStatusController.dispose();
    dtSolicitacaoController.dispose();
    dtSolicitacaoFocus.dispose();
    idBeneficiarioController.dispose();
    codBeneficiarioController.dispose();
    nomeBeneficiarioController.dispose();
    contratoBeneficiarioController.dispose();
    telefoneController.dispose();
    emailController.dispose();
    idMedSolController.dispose();
    nomeMedSolController.dispose();
    idResponsavelController.dispose();
    nomeResponsavelController.dispose();
    idTipoAtendimentoController.dispose();
    nomeTipoAtendimentoController.dispose();
    idAssuntoController.dispose();
    nomeAssuntoController.dispose();
    idCanalController.dispose();
    nomeCanalController.dispose();
    idCaraterAtendimentoController.dispose();
    nomeCaraterAtendimentoController.dispose();
    tituloController.dispose();
    descricaoController.dispose();
    _dadosTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _alterarModoAlteracao() {
    setState(() {
      inclusaoEvento = false;
      alteracaoEvento = true;
    });
  }

  void _alterarModoInclusao() {
    setState(() {
      inclusaoEvento = true;
      alteracaoEvento = false;
    });
  }

  Future<void> _carregarDados() async {
    if (await utils.logonValidation()) {
      atendimentoCarregado = Atendimento();
      final retorno = await _sharedPref.read('pessoaLogada') ?? '{}';
      setState(() => pessoaLogada = UserAction.fromJson(jsonDecode(retorno)['usuarioActions']));
      protocoloController.text = await _sharedPref.read('protocolo') ?? '';
      if (protocoloController.text.isNotEmpty) {
        var filtro = AtendimentoSC();
        filtro.protocolo = protocoloController.text;
        final atendimentoRes = await atendimentoReq.reqListarAtendimento(filtro, true, context);
        setState(() {
          atendimentoCarregado = atendimentoRes.first;
          isModoInclusao = false;
        });
        _popularCampos();
      } else {
        dtSolicitacaoController.text = utils.dateFormatter(DateTime.now().toString());
        _dadosTimer = Timer.periodic(Duration(seconds: 1), (timer) {
          if (!mounted) {
            timer.cancel();
            return;
          }
          setState(() {
            dtSolicitacaoController.text = utils.dateFormatter(DateTime.now().toString());
            idResponsavelController.text = pessoaLogada.usuario?.id ?? '';
            nomeResponsavelController.text = pessoaLogada.usuario?.nome ?? '';
          });
        });
      }
    } else {
      if (mounted) context.replace('/');
    }
  }

  Future<void> _carregarEventos() async {
    var res = await eventoReq.reqListarEvento(atendimentoCarregado.id ?? '', context);
    eventos.clear();
    setState(() => eventos = res);
  }

  void _limparCampos() async {
    await _sharedPref.remove('protocolo');
    await _sharedPref.remove('responsavel');
    protocoloController.clear();
    idStatusController.clear();
    nomeStatusController.clear();
    dtSolicitacaoController.clear();
    idBeneficiarioController.clear();
    codBeneficiarioController.clear();
    nomeBeneficiarioController.clear();
    telefoneController.clear();
    emailController.clear();
    idMedSolController.clear();
    nomeMedSolController.clear();
    idResponsavelController.clear();
    nomeResponsavelController.clear();
    idTipoAtendimentoController.clear();
    nomeTipoAtendimentoController.clear();
    idAssuntoController.clear();
    nomeAssuntoController.clear();
    idCanalController.clear();
    nomeCanalController.clear();
    idCaraterAtendimentoController.clear();
    nomeCaraterAtendimentoController.clear();
    tituloController.clear();
    descricaoController.clear();
    setState(() {
      atendimentoCarregado = Atendimento();
      eventoCarregado = Evento();
      eventos = [];
      anexos = [];
      isModoInclusao = true;
      isCanceladoFinalizado = false;
      inclusaoEvento = false;
      alteracaoEvento = false;
      agendaMedica = false;
      transferencia = false;
      contrato = false;
    });
    _carregarDados();
  }

  void _limparCamposEventos() {
    tituloController.clear();
    descricaoController.clear();
    setState(() {
      eventoCarregado = Evento();
    });
    _alterarModoInclusao();
  }

  void _mostrarBarraCarregamento() {
    setState(() => barraCarregamento = !barraCarregamento);
  }

  Future<void> _popularCampos() async {
    protocoloController.text = atendimentoCarregado.protocolo ?? '';
    idStatusController.text = atendimentoCarregado.status?.id ?? '';
    nomeStatusController.text = atendimentoCarregado.status?.nome ?? '';
    dtSolicitacaoController.text = utils.dateFormatter(atendimentoCarregado.dtSolicitacao ?? '');
    idBeneficiarioController.text = atendimentoCarregado.beneficiarioCarteirinha != null ? atendimentoCarregado.beneficiarioCarteirinha.toString() : '';
    codBeneficiarioController.text = atendimentoCarregado.beneficiarioCpf ?? '';
    nomeBeneficiarioController.text = atendimentoCarregado.beneficiarioNome ?? '';
    contratoBeneficiarioController.text = atendimentoCarregado.beneficiarioContrato ?? '';
    telefoneController.text = atendimentoCarregado.telefone ?? '';
    emailController.text = atendimentoCarregado.email ?? '';
    idMedSolController.text = atendimentoCarregado.prestadorAutoid.toString();
    nomeMedSolController.text = atendimentoCarregado.prestadorNome ?? '';
    idResponsavelController.text = atendimentoCarregado.responsavel?.id ?? '';
    nomeResponsavelController.text = atendimentoCarregado.responsavel?.nome ?? '';
    idTipoAtendimentoController.text = atendimentoCarregado.tipo?.id ?? '';
    nomeTipoAtendimentoController.text = atendimentoCarregado.tipo?.nome ?? '';
    idAssuntoController.text = atendimentoCarregado.assunto?.id ?? '';
    nomeAssuntoController.text = atendimentoCarregado.assunto?.nome ?? '';
    idCanalController.text = atendimentoCarregado.canal?.id ?? '';
    nomeCanalController.text = atendimentoCarregado.canal?.nome ?? '';
    idCaraterAtendimentoController.text = atendimentoCarregado.carater?.id ?? '';
    nomeCaraterAtendimentoController.text = atendimentoCarregado.carater?.nome ?? '';
    setState(() {
      if (nomeTipoAtendimentoController.text == 'Agenda Médica') {
        agendaMedica = true;
        transferencia = false;
      } else if (nomeTipoAtendimentoController.text == 'Transferência') {
        agendaMedica = false;
        transferencia = true;
      } else {
        agendaMedica = false;
        transferencia = false;
      }
      if (contratoBeneficiarioController.text.isNotEmpty) {
        contrato = true;
      } else {
        contrato = false;
      }
      if (atendimentoCarregado.status?.nome == 'FECHADO' ||
          atendimentoCarregado.status?.nome == 'CANCELADO' ||
          atendimentoCarregado.status?.nome == 'FINALIZADO') {
        isCanceladoFinalizado = true;
        inclusaoEvento = false;
        alteracaoEvento = false;
      } else {
        inclusaoEvento = true;
        alteracaoEvento = false;
      }
      isModoInclusao = false;
    });
    if (atendimentoCarregado.id != null) _carregarEventos();
  }
}
