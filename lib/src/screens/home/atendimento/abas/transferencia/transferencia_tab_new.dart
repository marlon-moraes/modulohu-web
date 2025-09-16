// ignore_for_file: use_build_context_synchronously

// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/atendimento.dart';
import 'package:modulohu_web/src/models/cadastros_transferencia_res.dart';
import 'package:modulohu_web/src/models/responsavel.dart';
import 'package:modulohu_web/src/models/responsavel_transferencia.dart';
import 'package:modulohu_web/src/models/transferencia.dart';
import 'package:modulohu_web/src/models/user_action.dart';
import 'package:modulohu_web/src/screens/home/atendimento/abas/atendimento/abas/anexos_tab.dart';
import 'package:modulohu_web/src/screens/home/atendimento/abas/transferencia/dialog/dialog_cadastro_transferencia.dart';
import 'package:modulohu_web/src/screens/home/dialog/dialog_listagem.dart';
import 'package:modulohu_web/src/services/api/req/beneficiario_req.dart';
import 'package:modulohu_web/src/services/api/req/pessoa_cadastro_req.dart';
import 'package:modulohu_web/src/services/api/req/responsavel_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_cobertura_contratual_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_convenio_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_equipe_transporte_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_meio_transporte_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_motivo_nao_atendida_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_motivo_rejeitado_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_motivo_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_precaucao_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_req.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_tipo_internacao_req.dart';
import 'package:modulohu_web/src/utils/shared_pref.dart';

class TransferenciaTabNew extends StatefulWidget {
  final UserAction pessoaLogada;
  final Atendimento atendimentoCarregado;
  final bool isModoInclusao;
  final bool isCanceladoFinalizado;
  final int? beneficiarioCarteirinha;
  final String beneficiarioNome;
  final String beneficiarioCnp;

  const TransferenciaTabNew({
    super.key,
    required this.pessoaLogada,
    required this.atendimentoCarregado,
    required this.isModoInclusao,
    required this.isCanceladoFinalizado,
    required this.beneficiarioCarteirinha,
    required this.beneficiarioNome,
    required this.beneficiarioCnp,
  });

  @override
  State<TransferenciaTabNew> createState() => _TransferenciaTabNewState();
}

class _TransferenciaTabNewState extends State<TransferenciaTabNew> {
  final _formKey = GlobalKey<FormState>();
  final _sharedPref = SharedPref();
  var dtSolicitacaoController = TextEditingController();
  var idResponsavelController = TextEditingController();
  var codResponsavelController = TextEditingController();
  var nomeResponsavelController = TextEditingController();
  var nomePacienteController = TextEditingController();
  var dtNascimentoController = TextEditingController();
  var precaucaoController = TextEditingController();
  var qualPrecaucaoController = TextEditingController();
  var telefoneController = TextEditingController();
  var prontuarioController = TextEditingController();
  var carteirinhaController = TextEditingController();
  var coberturaContratualController = TextEditingController();
  var convenioController = TextEditingController();
  var equipeTransporteController = TextEditingController();
  var meioTransporteController = TextEditingController();
  var motivoController = TextEditingController();
  var motivoNaoAtendidaController = TextEditingController();
  var motivoRejeitadoController = TextEditingController();
  var motivoSolicitacaoController = TextEditingController();
  var tipoInternacaoController = TextEditingController();
  var familiarResponsavelController = TextEditingController();
  var contatoFamiliarController = TextEditingController();
  var idInstituicaoOrigemController = TextEditingController();
  var codInstituicaoOrigemController = TextEditingController();
  var nomeInstituicaoOrigemController = TextEditingController();
  var leitoController = TextEditingController();
  var idInstituicaoReferenciaController = TextEditingController();
  var codInstituicaoReferenciaController = TextEditingController();
  var nomeInstituicaoReferenciaController = TextEditingController();
  var idMedSolController = TextEditingController();
  var codMedSolController = TextEditingController();
  var nomeMedSolController = TextEditingController();
  var contatoMedSolController = TextEditingController();
  var idMedRecController = TextEditingController();
  var codMedRecController = TextEditingController();
  var nomeMedRecController = TextEditingController();
  var motivoAprovacaoController = TextEditingController();
  var leitoDisponivelController = TextEditingController();
  var motivoTransferenciaController = TextEditingController();
  var tipoInternacaoNomeController = TextEditingController();
  var motivoSolicitacaoAtendidaController = TextEditingController();
  var medicosSolicitadosController = TextEditingController();
  var dadosClinicosAnotacoesController = TextEditingController();
  var horaSaidaController = TextEditingController();
  var horaChegadaController = TextEditingController();
  var dataController = TextEditingController();
  String? _sexoValue;
  bool? _coberturaContratualValue;
  String? _acomodacaoValue;
  bool? _aprovacaolValue;
  bool? _leitoDisponivelValue;
  bool? _solicitacaoAtendidaValue;
  var barraCarregamento = false;
  var funcionarioResponsavel = Responsavel();
  var convenioSelecionada = CadastrosTransferenciaRes();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var transferencia = Transferencia();
    var coberturaContratualSelecionada = CadastrosTransferenciaRes();
    var equipeTransporteSelecionada = CadastrosTransferenciaRes();
    var meioTransporteSelecionada = CadastrosTransferenciaRes();
    var motivoSelecionada = CadastrosTransferenciaRes();
    var motivoNaoAtendidaSelecionada = CadastrosTransferenciaRes();
    var motivoRejeitadoSelecionada = CadastrosTransferenciaRes();
    // var motivoSolicitacaoSelecionada = CadastrosTransferenciaRes();
    var precaucaoSelecionada = CadastrosTransferenciaRes();
    var tipoInternacaoSelecionada = CadastrosTransferenciaRes();

    Widget dtSolicitacao() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              controller: dtSolicitacaoController,
              inputFormatters: [mascaraDataHora],
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

    Widget responsavel() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              controller: nomeResponsavelController,
              text: 'Funcionário Responsável',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado) {
                  final res = await reqListarResponsavel(context);
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return DialogListagem(
                        title: 'Responsável',
                        list: res,
                        id: idResponsavelController,
                        cod: TextEditingController(),
                        nome: nomeResponsavelController,
                        pessoaLogada: widget.pessoaLogada,
                        contrato: TextEditingController(),
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget nome() {
      return FormTextField(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        controller: nomePacienteController,
        text: 'Nome Completo do Paciente',
      );
    }

    Widget dtNascimento() {
      return FormTextField(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        controller: dtNascimentoController,
        text: 'Data de Nascimento',
      );
    }

    Widget sexo() {
      return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Sexo: '),
            Expanded(
              child: RadioListTile(
                onChanged: (value) => setState(() => _sexoValue = value),
                groupValue: _sexoValue,
                title: Text(Responsive.isLargeScreen(context) ? 'Masculino' : 'M'),
                value: 'MASCULINO',
              ),
            ),
            Expanded(
              child: RadioListTile(
                onChanged: (value) => setState(() => _sexoValue = value),
                groupValue: _sexoValue,
                title: Text(Responsive.isLargeScreen(context) ? 'Feminino' : 'F'),
                value: 'FEMININO',
              ),
            ),
          ],
        ),
      );
    }

    Widget precaucao() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              controller: precaucaoController,
              text: 'Precaução',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado) {
                  final res = await reqListarPrecaucao(context);
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return DialogCadastroTransferencia(title: 'Precaução', list: res, pessoaLogada: widget.pessoaLogada, nome: precaucaoController);
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget telefone() {
      return FormTextField(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        inputFormatters: [mascaraCelular],
        controller: telefoneController,
        text: 'Telefone',
      );
    }

    Widget convenio() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              controller: convenioController,
              text: 'Convênio',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado) {
                  final res = await reqListarConvenio(context);
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return DialogCadastroTransferencia(title: 'Convênio', list: res, pessoaLogada: widget.pessoaLogada, nome: convenioController);
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget prontuario() {
      return FormTextField(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        controller: prontuarioController,
        inputFormatters: [onlyNumbers],
        text: 'Prontuário',
      );
    }

    Widget carteirinha() {
      return FormTextField(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        controller: carteirinhaController,
        text: 'Nº Carteirinha do Paciente',
        inputFormatters: [onlyNumbers],
      );
    }

    Widget coberturaContratual() {
      return
      // Container(
      //   decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
      //   margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      //   padding: EdgeInsets.symmetric(horizontal: 8),
      //   child:
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text('Cobertura Contratual: '),
          Expanded(
            child: RadioListTile(
              onChanged: (value) {
                coberturaContratualController.clear();
                setState(() {
                  coberturaContratualSelecionada = CadastrosTransferenciaRes();
                  _coberturaContratualValue = value;
                });
              },
              groupValue: _coberturaContratualValue,
              title: const Text('Sim'),
              value: true,
            ),
          ),
          Expanded(
            child: RadioListTile(
              onChanged: (value) => setState(() => _coberturaContratualValue = value),
              groupValue: _coberturaContratualValue,
              title: const Text('Não'),
              value: false,
            ),
          ),
        ],
        // ),
      );
    }

    Widget motivoCobertura() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              controller: coberturaContratualController,
              enabled: false,
              text: 'Motivo',
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado && !(_coberturaContratualValue ?? true)) {
                  final res = await reqListarCoberturaContratual(context);
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return DialogCadastroTransferencia(
                        title: 'Cobertura Contratual',
                        list: res,
                        pessoaLogada: widget.pessoaLogada,
                        nome: coberturaContratualController,
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado && !(_coberturaContratualValue ?? true) ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget acomodacao() {
      return
      // Container(
      //   decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
      //   margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      //   padding: EdgeInsets.symmetric(horizontal: 8),
      //   child:
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text('Acomodação: '),
          Expanded(
            child: RadioListTile(
              onChanged: (value) => setState(() => _acomodacaoValue = value),
              title: const Text('Semi-privativo'),
              groupValue: _acomodacaoValue,
              value: 'SEMI_PRIVATIVO',
            ),
          ),
          Expanded(
            child: RadioListTile(
              onChanged: (value) => setState(() => _acomodacaoValue = value),
              title: const Text('Privativo'),
              groupValue: _acomodacaoValue,
              value: 'PRIVATIVO',
            ),
          ),
        ],
        // ),
      );
    }

    Widget familiarResponsavel() {
      return FormTextField(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        text: 'Familiar/Responsável pelo Paciente',
        controller: familiarResponsavelController,
      );
    }

    Widget contatoFamiliar() {
      return FormTextField(margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), controller: contatoFamiliarController, text: 'Contato');
    }

    Widget instituicaoOrigem() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              controller: nomeInstituicaoOrigemController,
              text: 'Instituição de Origem',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogListagem(
                        title: 'Instituição de Origem',
                        list: [],
                        id: idInstituicaoOrigemController,
                        cod: codInstituicaoOrigemController,
                        nome: nomeInstituicaoOrigemController,
                        pessoaLogada: widget.pessoaLogada,
                        contrato: TextEditingController(),
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget leito() {
      return FormTextField(margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), controller: leitoController, text: 'Leito');
    }

    Widget instituicaoReferencia() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              controller: nomeInstituicaoReferenciaController,
              text: 'Instituição de Referência',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogListagem(
                        title: 'Instituição de Referência',
                        list: [],
                        id: idInstituicaoReferenciaController,
                        cod: codInstituicaoReferenciaController,
                        nome: nomeInstituicaoReferenciaController,
                        pessoaLogada: widget.pessoaLogada,
                        contrato: TextEditingController(),
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
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
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              controller: nomeMedSolController,
              text: 'Médico Solicitante',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogListagem(
                        title: 'Médico Solicitante ',
                        list: [],
                        id: idMedSolController,
                        cod: codMedSolController,
                        nome: nomeMedSolController,
                        pessoaLogada: widget.pessoaLogada,
                        contrato: TextEditingController(),
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget contatoMedico() {
      return FormTextField(margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), controller: contatoMedSolController, text: 'Contato');
    }

    Widget medicoQueIraReceber() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              text: 'Médico que irá Receber o Paciente',
              controller: nomeMedRecController,
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogListagem(
                        title: 'Médico que irá Receber o Paciente',
                        list: [],
                        id: idMedRecController,
                        cod: codMedRecController,
                        nome: nomeMedRecController,
                        pessoaLogada: widget.pessoaLogada,
                        contrato: TextEditingController(),
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget aprovacao() {
      return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(''),
            Expanded(
              child: RadioListTile(
                onChanged: (value) {
                  motivoRejeitadoController.clear();
                  setState(() {
                    _aprovacaolValue = value;
                    motivoRejeitadoSelecionada = CadastrosTransferenciaRes();
                  });
                },
                title: const Text('Aprovado'),
                groupValue: _aprovacaolValue,
                value: true,
              ),
            ),
            Expanded(
              child: RadioListTile(
                onChanged: (value) => setState(() => _aprovacaolValue = value),
                title: const Text('Rejeitado'),
                groupValue: _aprovacaolValue,
                value: false,
              ),
            ),
          ],
        ),
      );
    }

    Widget motivoRejeitado() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              controller: motivoRejeitadoController,
              text: 'Motivo',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado && !(_aprovacaolValue ?? true)) {
                  final res = await reqListarMotivoRejeitado(context);
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return DialogCadastroTransferencia(
                        title: 'Motivo Rejeitado',
                        list: res,
                        pessoaLogada: widget.pessoaLogada,
                        nome: motivoRejeitadoController,
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado && !(_aprovacaolValue ?? true) ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget leitoDisponivel() {
      return
      // Container(
      //   decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
      //   margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      //   padding: EdgeInsets.symmetric(horizontal: 8),
      //   child:
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text('Leito Disponível: '),
          Expanded(
            child: RadioListTile(
              onChanged: (value) => setState(() => _leitoDisponivelValue = value),
              groupValue: _leitoDisponivelValue,
              title: const Text('Sim'),
              value: true,
            ),
          ),
          Expanded(
            child: RadioListTile(
              onChanged: (value) => setState(() => _leitoDisponivelValue = value),
              groupValue: _leitoDisponivelValue,
              title: const Text('Não'),
              value: false,
            ),
          ),
        ],
        // ),
      );
    }

    Widget motivoTransferencia() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              text: 'Motivo da Transferência',
              controller: motivoController,
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado) {
                  final res = await reqListarMotivo(context);
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return DialogCadastroTransferencia(title: 'Motivo', list: res, pessoaLogada: widget.pessoaLogada, nome: motivoController);
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget tipoInternacao() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              controller: tipoInternacaoController,
              text: 'Tipo de Internação',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado) {
                  final res = await reqListarTipoInternacao(context);
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return DialogCadastroTransferencia(
                        title: 'Tipo de Internação',
                        list: res,
                        pessoaLogada: widget.pessoaLogada,
                        nome: tipoInternacaoController,
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget solicitacaoAtendida() {
      return
      // Container(
      //   decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
      //   margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      //   padding: EdgeInsets.symmetric(horizontal: 8),
      //   child:
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text('Solicitação Atendida: '),
          Expanded(
            child: RadioListTile(
              onChanged: (value) {
                motivoSolicitacaoController.clear();
                setState(() {
                  _solicitacaoAtendidaValue = value;
                  // motivoSolicitacaoSelecionada = CadastrosTransferenciaRes();
                });
              },
              groupValue: _solicitacaoAtendidaValue,
              title: const Text('Sim'),
              value: true,
            ),
          ),
          Expanded(
            child: RadioListTile(
              onChanged: (value) => setState(() => _solicitacaoAtendidaValue = value),
              groupValue: _solicitacaoAtendidaValue,
              title: const Text('Não'),
              value: false,
            ),
          ),
        ],
        // ),
      );
    }

    Widget motivoSolicitacao() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              controller: motivoNaoAtendidaController,
              enabled: false,
              text: 'Motivo',
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado && !(_solicitacaoAtendidaValue ?? true)) {
                  final res = await reqListarMotivoNaoAtendida(context);
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return DialogCadastroTransferencia(
                        title: 'Motivo não Atendida',
                        list: res,
                        pessoaLogada: widget.pessoaLogada,
                        nome: motivoNaoAtendidaController,
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado && !(_solicitacaoAtendidaValue ?? true) ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget medicosSolicitados() {
      return FormTextField(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        text: 'Médicos Solicitados (motivo pelo qual não atendeu)',
        controller: medicosSolicitadosController,
      );
    }

    Widget dadosClinicosAnotacoes() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            labelStyle: theme.textTheme.bodyMedium,
            labelText: 'Dados Clínicos/Anotações',
            border: const OutlineInputBorder(),
            isDense: true,
          ),
          controller: dadosClinicosAnotacoesController,
          maxLines: 5,
        ),
      );
    }

    Widget meioTransporte() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              controller: meioTransporteController,
              text: 'Meio de Transporte',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado) {
                  final res = await reqListarMeioTransporte(context);
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return DialogCadastroTransferencia(
                        title: 'Meio de Transporte',
                        list: res,
                        pessoaLogada: widget.pessoaLogada,
                        nome: meioTransporteController,
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget equipeTransporte() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              controller: equipeTransporteController,
              text: 'Equipe de Transporte',
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () async {
                if (!widget.isCanceladoFinalizado) {
                  final res = await reqListarEquipeTransporte(context);
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return DialogCadastroTransferencia(
                        title: 'Equipe de Transporte',
                        list: res,
                        pessoaLogada: widget.pessoaLogada,
                        nome: equipeTransporteController,
                      );
                    },
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Widget horaSaida() {
      return FormTextField(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        controller: horaSaidaController,
        inputFormatters: [mascaraHora],
        text: 'Horário de Saída',
      );
    }

    Widget horaChegada() {
      return FormTextField(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        controller: horaChegadaController,
        inputFormatters: [mascaraHora],
        text: 'Horário de Chegada',
      );
    }

    Widget data() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormTextField(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              inputFormatters: [mascaraData],
              controller: dataController,
              text: 'Data',
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 4),
            child: InkWell(
              onTap: () {
                if (!widget.isCanceladoFinalizado) selecionarData(dataController, null, context);
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: !widget.isCanceladoFinalizado ? theme.colorScheme.primary : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      );
    }

    Future<void> salvar() async {
      if (!barraCarregamento) {
        _formKey.currentState!.save();
        _mostrarBarraCarregamento();
        transferencia.idEmp = widget.pessoaLogada.usuario?.empresa?.id;
        transferencia.idUni = widget.pessoaLogada.unidades?.first.idUni;
        transferencia.idAtendimentoCRA = IdAtendimentoCRA(id: widget.atendimentoCarregado.id);
        transferencia.nome = nomePacienteController.text;
        transferencia.dtNascimento = dateFormatter2(dtNascimentoController.text, false);
        transferencia.sexo = _sexoValue;
        transferencia.telefone = telefoneController.text;
        transferencia.prontuario = int.tryParse(prontuarioController.text);
        transferencia.acomodacao = _acomodacaoValue;
        transferencia.familiarResponsavel = familiarResponsavelController.text;
        transferencia.familiarResponsavelContato = contatoFamiliarController.text;
        transferencia.leitoDisponivel = _leitoDisponivelValue;
        transferencia.leito = leitoController.text;
        transferencia.medicosSolicitados = medicosSolicitadosController.text;
        transferencia.condicoesPaciente = dadosClinicosAnotacoesController.text;
        transferencia.idInstituicaoOrigem = idInstituicaoOrigemController.text;
        transferencia.idInstituicaoReferencia = idInstituicaoReferenciaController.text;
        transferencia.idMedicoSolicitante = idMedSolController.text;
        transferencia.medicoSolicitanteContato = contatoMedSolController.text;
        transferencia.idMedicoRecebimento = idMedRecController.text;
        funcionarioResponsavel = Responsavel.fromJson(jsonDecode(await _sharedPref.read('responsavel') ?? '{}'));
        precaucaoSelecionada = CadastrosTransferenciaRes.fromJson(jsonDecode(await _sharedPref.read('precaucao') ?? '{}'));
        convenioSelecionada = CadastrosTransferenciaRes.fromJson(jsonDecode(await _sharedPref.read('convenio') ?? '{}'));
        coberturaContratualSelecionada = CadastrosTransferenciaRes.fromJson(jsonDecode(await _sharedPref.read('coberturaContratual') ?? '{}'));
        motivoRejeitadoSelecionada = CadastrosTransferenciaRes.fromJson(jsonDecode(await _sharedPref.read('motivoRejeitado') ?? '{}'));
        motivoSelecionada = CadastrosTransferenciaRes.fromJson(jsonDecode(await _sharedPref.read('motivo') ?? '{}'));
        tipoInternacaoSelecionada = CadastrosTransferenciaRes.fromJson(jsonDecode(await _sharedPref.read('tipoInternacao') ?? '{}'));
        motivoNaoAtendidaSelecionada = CadastrosTransferenciaRes.fromJson(jsonDecode(await _sharedPref.read('motivoNaoAtendida') ?? '{}'));
        meioTransporteSelecionada = CadastrosTransferenciaRes.fromJson(jsonDecode(await _sharedPref.read('meioTransporte') ?? '{}'));
        equipeTransporteSelecionada = CadastrosTransferenciaRes.fromJson(jsonDecode(await _sharedPref.read('equipeTransporte') ?? '{}'));
        transferencia.responsavel = ResponsavelTransferencia(
          id: funcionarioResponsavel.id,
          codigo: funcionarioResponsavel.codigo,
          dtInc: funcionarioResponsavel.dtInc,
          dtAlt: funcionarioResponsavel.dtAlt,
        );
        transferencia.precaucao = precaucaoSelecionada.id != null ? precaucaoSelecionada : null;
        transferencia.convenio = convenioSelecionada.id != null ? convenioSelecionada : null;
        transferencia.coberturaContratual = coberturaContratualSelecionada.id != null ? coberturaContratualSelecionada : null;
        transferencia.motivoRejeitado = motivoRejeitadoSelecionada.id != null ? motivoRejeitadoSelecionada : null;
        transferencia.motivoTransferencia = motivoSelecionada.id != null ? motivoSelecionada : null;
        transferencia.tipoInterncao = tipoInternacaoSelecionada.id != null ? tipoInternacaoSelecionada : null;
        transferencia.solicitacaoAtendida = motivoNaoAtendidaSelecionada.id != null ? motivoNaoAtendidaSelecionada : null;
        transferencia.meioTransporteTransf = meioTransporteSelecionada.id != null ? meioTransporteSelecionada : null;
        transferencia.equipeTransporteTransf = equipeTransporteSelecionada.id != null ? equipeTransporteSelecionada : null;
        if (dataController.text.isNotEmpty && horaChegadaController.text.isNotEmpty) {
          transferencia.dtChegada = dateFormatter2('${dataController.text} ${horaChegadaController.text}:00', true);
        }
        if (dataController.text.isNotEmpty && horaSaidaController.text.isNotEmpty) {
          transferencia.dtSaida = dateFormatter2('${dataController.text} ${horaSaidaController.text}:00', true);
        }
        transferencia.idUsuAlt = IdAtendimentoCRA(id: widget.pessoaLogada.usuario?.id);
        var res = await reqIncluirTransferencia(transferencia, context);
        _mostrarBarraCarregamento();
        if (res) {
          // await _sharedPref.remove('responsavel');
          // await _sharedPref.remove('precaucao');
          // await _sharedPref.remove('convenio');
          // await _sharedPref.remove('coberturaContratual');
          // await _sharedPref.remove('motivoRejeitado');
          // await _sharedPref.remove('motivo');
          // await _sharedPref.remove('tipoInternacao');
          // await _sharedPref.remove('motivoNaoAtendida');
          // await _sharedPref.remove('meioTransporte');
          // await _sharedPref.remove('equipeTransporte');
        }
      }
    }

    return Form(
      key: _formKey,
      child:
          Responsive.isLargeScreen(context)
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [Expanded(child: dtSolicitacao()), Expanded(child: responsavel())]),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [Expanded(flex: 2, child: nome()), Expanded(child: dtNascimento())]),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Expanded(flex: 2, child: sexo()), Expanded(child: telefone()), Expanded(flex: 2, child: precaucao())],
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [Expanded(flex: 2, child: convenio()), Expanded(child: prontuario())]),
                  carteirinha(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Text('Cobertura Contratual: '), Expanded(child: coberturaContratual())],
                          ),
                        ),
                      ),
                      Expanded(child: motivoCobertura()),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [Text('Acomodação: '), Expanded(child: acomodacao())]),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Expanded(child: familiarResponsavel()), Expanded(child: contatoFamiliar())],
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [Expanded(child: instituicaoOrigem()), Expanded(child: leito())]),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Expanded(child: instituicaoReferencia()), Expanded(child: medicoSolicitante()), Expanded(child: contatoMedico())],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Expanded(child: medicoQueIraReceber()), Expanded(child: aprovacao()), Expanded(child: motivoRejeitado())],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Text('Leito Disponível: '), Expanded(child: leitoDisponivel())],
                          ),
                        ),
                      ),
                      Expanded(child: motivoTransferencia()),
                      Expanded(child: tipoInternacao()),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Text('Solicitação Atendida: '), Expanded(child: solicitacaoAtendida())],
                          ),
                        ),
                      ),
                      Expanded(child: motivoSolicitacao()),
                    ],
                  ),
                  medicosSolicitados(),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: theme.colorScheme.primary), borderRadius: BorderRadius.circular(4)),
                        margin: EdgeInsets.fromLTRB(8, 10, 8, 8),
                        padding: EdgeInsets.only(top: 4),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Column(children: [SizedBox(height: 5), dadosClinicosAnotacoes()]),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(color: theme.canvasColor),
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Text('Condições do Paciente', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: theme.colorScheme.primary), borderRadius: BorderRadius.circular(4)),
                        margin: EdgeInsets.fromLTRB(8, 10, 8, 8),
                        padding: EdgeInsets.only(top: 4),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            children: [
                              SizedBox(height: 5),
                              Row(children: [Expanded(child: meioTransporte()), Expanded(child: equipeTransporte())]),
                              Row(children: [Expanded(child: horaSaida()), Expanded(child: horaChegada()), Expanded(child: data())]),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(color: theme.canvasColor),
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Text('Meio de Transporte', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: theme.colorScheme.primary), borderRadius: BorderRadius.circular(4)),
                        margin: EdgeInsets.fromLTRB(8, 10, 8, 8),
                        padding: EdgeInsets.only(top: 4),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: AnexosTab(
                            pessoaLogada: widget.pessoaLogada,
                            atendimentoCarregado: widget.atendimentoCarregado,
                            isModoInclusao: widget.isModoInclusao,
                            isCanceladoFinalizado: widget.isCanceladoFinalizado,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(color: theme.canvasColor),
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Text('Anexo', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  loadingBar(barraCarregamento),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        buttonColor: !widget.isCanceladoFinalizado ? Colors.green : Colors.grey,
                        onPressed: () => !widget.isCanceladoFinalizado ? salvar() : null,
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        text: 'Salvar',
                      ),
                    ],
                  ),
                ],
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  dtSolicitacao(),
                  responsavel(),
                  nome(),
                  dtNascimento(),
                  sexo(),
                  telefone(),
                  precaucao(),
                  convenio(),
                  prontuario(),
                  carteirinha(),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Cobertura Contratual:'), coberturaContratual()]),
                  ),
                  motivoCobertura(),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Acomodação:'), acomodacao()]),
                  ),
                  familiarResponsavel(),
                  contatoFamiliar(),
                  instituicaoOrigem(),
                  leito(),
                  instituicaoReferencia(),
                  medicoSolicitante(),
                  contatoMedico(),
                  medicoQueIraReceber(),
                  aprovacao(),
                  motivoRejeitado(),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Leito DIsponível:'), leitoDisponivel()]),
                  ),
                  motivoTransferencia(),
                  tipoInternacao(),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)),
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Solicitação Atendida:'), solicitacaoAtendida()]),
                  ),
                  motivoSolicitacao(),
                  medicosSolicitados(),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: theme.colorScheme.primary), borderRadius: BorderRadius.circular(4)),
                        margin: EdgeInsets.fromLTRB(8, 10, 8, 8),
                        padding: EdgeInsets.only(top: 4),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Column(children: [SizedBox(height: 5), dadosClinicosAnotacoes()]),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(color: theme.canvasColor),
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Text('Condições do Paciente', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: theme.colorScheme.primary), borderRadius: BorderRadius.circular(4)),
                        margin: EdgeInsets.fromLTRB(8, 10, 8, 8),
                        padding: EdgeInsets.only(top: 4),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Column(children: [SizedBox(height: 5), meioTransporte(), equipeTransporte(), horaSaida(), horaChegada(), data()]),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(color: theme.canvasColor),
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Text('Meio de Transporte', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: theme.colorScheme.primary), borderRadius: BorderRadius.circular(4)),
                        margin: EdgeInsets.fromLTRB(8, 10, 8, 8),
                        padding: EdgeInsets.only(top: 4),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            children: [
                              SizedBox(height: 5),
                              AnexosTab(
                                pessoaLogada: widget.pessoaLogada,
                                atendimentoCarregado: widget.atendimentoCarregado,
                                isModoInclusao: widget.isModoInclusao,
                                isCanceladoFinalizado: widget.isCanceladoFinalizado,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(color: theme.canvasColor),
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Text('Anexo', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  loadingBar(barraCarregamento),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        buttonColor: !widget.isCanceladoFinalizado ? Colors.green : Colors.grey,
                        onPressed: () => !widget.isCanceladoFinalizado ? salvar() : null,
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        text: 'Salvar',
                      ),
                    ],
                  ),
                ],
              ),
    );
  }

  @override
  void dispose() {
    // Controllers de dados do paciente
    dtSolicitacaoController.dispose();
    nomeResponsavelController.dispose();
    nomePacienteController.dispose();
    dtNascimentoController.dispose();
    precaucaoController.dispose();
    qualPrecaucaoController.dispose();
    telefoneController.dispose();
    prontuarioController.dispose();
    carteirinhaController.dispose();
    // Controllers de dados da transferência
    coberturaContratualController.dispose();
    convenioController.dispose();
    equipeTransporteController.dispose();
    meioTransporteController.dispose();
    motivoController.dispose();
    motivoNaoAtendidaController.dispose();
    motivoRejeitadoController.dispose();
    motivoSolicitacaoController.dispose();
    tipoInternacaoController.dispose();
    // Controllers de dados do familiar
    familiarResponsavelController.dispose();
    contatoFamiliarController.dispose();
    // Controllers de instituição
    idInstituicaoOrigemController.dispose();
    codInstituicaoOrigemController.dispose();
    nomeInstituicaoOrigemController.dispose();
    leitoController.dispose();
    idInstituicaoReferenciaController.dispose();
    codInstituicaoReferenciaController.dispose();
    nomeInstituicaoReferenciaController.dispose();
    // Controllers de médicos
    idMedSolController.dispose();
    codMedSolController.dispose();
    nomeMedSolController.dispose();
    contatoMedSolController.dispose();
    idMedRecController.dispose();
    codMedRecController.dispose();
    nomeMedRecController.dispose();
    // Controllers adicionais
    motivoAprovacaoController.dispose();
    leitoDisponivelController.dispose();
    motivoTransferenciaController.dispose();
    tipoInternacaoNomeController.dispose();
    motivoSolicitacaoAtendidaController.dispose();
    medicosSolicitadosController.dispose();
    dadosClinicosAnotacoesController.dispose();
    horaSaidaController.dispose();
    horaChegadaController.dispose();
    dataController.dispose();
    // Outros objetos
    funcionarioResponsavel = Responsavel();
    convenioSelecionada = CadastrosTransferenciaRes();
    _limparCampos();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    dtSolicitacaoController.text = dateFormatter(widget.atendimentoCarregado.dtSolicitacao ?? '');
    nomeResponsavelController.text = widget.pessoaLogada.usuario?.nome ?? '';
    final resFuncionario = await reqListarResponsavel(context);
    for (var element in resFuncionario) {
      // if (element.nome == widget.pessoaLogada.usuario?.nome) funcionarioResponsavel = element;
      await _sharedPref.save('responsavel', jsonEncode(element));
      break;
    }
    if (!mounted) return;
    final resPessoa = await reqListarBeneficiario(widget.beneficiarioCarteirinha, widget.beneficiarioNome, widget.beneficiarioCnp, true, context);
    if (!mounted) return;
    if (resPessoa.isNotEmpty) {
      final resTelefone = await reqCarregarTelefonePessoa(resPessoa.first.pessoa?.autoId.toString() ?? '', context);
      if (!mounted) return;
      nomePacienteController.text = resPessoa.first.pessoa?.nome ?? '';
      dtNascimentoController.text = dateFormatter(resPessoa.first.pessoa?.dtNascimento ?? '');
      if (!mounted) return;
      setState(() => _sexoValue = resPessoa.first.pessoa?.sexo);
      telefoneController.text = resTelefone;
      carteirinhaController.text = widget.beneficiarioCarteirinha != null ? widget.beneficiarioCarteirinha.toString() : '';
      String nome = resPessoa.first.contrato?.modelo?.tipoContratacao?.nome ?? '';
      if (!mounted) return;
      setState(() {
        _acomodacaoValue =
            nome.contains('Coletivo')
                ? 'SEMI_PRIVATIVO'
                : nome.contains('Individual')
                ? 'PRIVATIVO'
                : null;
      });
      final res = await reqListarConvenio(context);
      for (var element in res) {
        if (element.nome?.toLowerCase() == 'unimed vd') {
          await _sharedPref.save('convenio', jsonEncode(element));
          convenioController.text = element.nome ?? '';
        }
      }
    } else {
      nomePacienteController.text = widget.beneficiarioNome;
    }
  }

  void _limparCampos() async {
    await _sharedPref.remove('responsavel');
    await _sharedPref.remove('precaucao');
    await _sharedPref.remove('convenio');
    await _sharedPref.remove('coberturaContratual');
    await _sharedPref.remove('motivoRejeitado');
    await _sharedPref.remove('motivo');
    await _sharedPref.remove('tipoInternacao');
    await _sharedPref.remove('motivoNaoAtendida');
    await _sharedPref.remove('meioTransporte');
    await _sharedPref.remove('equipeTransporte');
    // Limpa todos os TextEditingController
    dtSolicitacaoController.clear();
    idResponsavelController.clear();
    codResponsavelController.clear();
    nomeResponsavelController.clear();
    nomePacienteController.clear();
    dtNascimentoController.clear();
    precaucaoController.clear();
    qualPrecaucaoController.clear();
    telefoneController.clear();
    prontuarioController.clear();
    carteirinhaController.clear();
    coberturaContratualController.clear();
    convenioController.clear();
    equipeTransporteController.clear();
    meioTransporteController.clear();
    motivoController.clear();
    motivoNaoAtendidaController.clear();
    motivoRejeitadoController.clear();
    motivoSolicitacaoController.clear();
    tipoInternacaoController.clear();
    familiarResponsavelController.clear();
    contatoFamiliarController.clear();
    idInstituicaoOrigemController.clear();
    codInstituicaoOrigemController.clear();
    nomeInstituicaoOrigemController.clear();
    leitoController.clear();
    idInstituicaoReferenciaController.clear();
    codInstituicaoReferenciaController.clear();
    nomeInstituicaoReferenciaController.clear();
    idMedSolController.clear();
    codMedSolController.clear();
    nomeMedSolController.clear();
    contatoMedSolController.clear();
    idMedRecController.clear();
    codMedRecController.clear();
    nomeMedRecController.clear();
    motivoAprovacaoController.clear();
    leitoDisponivelController.clear();
    motivoTransferenciaController.clear();
    tipoInternacaoNomeController.clear();
    motivoSolicitacaoAtendidaController.clear();
    medicosSolicitadosController.clear();
    dadosClinicosAnotacoesController.clear();
    horaSaidaController.clear();
    horaChegadaController.clear();
    dataController.clear();
    // Reseta os valores dos RadioListTile
    setState(() {
      _sexoValue = null;
      _coberturaContratualValue = null;
      _acomodacaoValue = null;
      _aprovacaolValue = null;
      _leitoDisponivelValue = null;
      _solicitacaoAtendidaValue = null;
    });
  }

  void _mostrarBarraCarregamento() {
    setState(() => barraCarregamento = !barraCarregamento);
  }
}
