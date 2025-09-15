// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/atendimento.dart';
import 'package:modulohu_web/src/models/transferencia.dart';
import 'package:modulohu_web/src/models/user_action.dart';
import 'package:modulohu_web/src/screens/home/atendimento/abas/atendimento/abas/anexos_tab.dart';
import 'package:modulohu_web/src/services/api/req/transferencia_req.dart';

class TransferenciaTab extends StatefulWidget {
  final UserAction pessoaLogada;
  final String idAtendimentoCRA;
  final Atendimento atendimentoCarregado;
  final bool isModoInclusao;
  final bool isCanceladoFinalizado;

  const TransferenciaTab({
    super.key,
    required this.pessoaLogada,
    required this.idAtendimentoCRA,
    required this.atendimentoCarregado,
    required this.isModoInclusao,
    required this.isCanceladoFinalizado,
  });

  @override
  State<TransferenciaTab> createState() => _TransferenciaTabState();
}

class _TransferenciaTabState extends State<TransferenciaTab> {
  final _formKey = GlobalKey<FormState>();
  final observacaoController = TextEditingController();
  var barraCarregamento = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    var transferencia = Transferencia();

    Future<void> salvar() async {
      if (!barraCarregamento) {
        _formKey.currentState!.save();
        _mostrarBarraCarregamento();
        var res = await reqIncluirTransferencia(transferencia, context);
        if (res) _limparCampos();
        _mostrarBarraCarregamento();
      }
    }

    Widget observacao() {
      return Expanded(
        flex: 4,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              labelStyle: theme.textTheme.bodyMedium,
              border: const OutlineInputBorder(),
              labelText: 'Observação',
              isDense: true,
            ),
            enabled: !widget.isCanceladoFinalizado,
            controller: observacaoController,
            maxLines: 3,
          ),
        ),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 4),
          SizedBox(
            width: Responsive.isLargeScreen(context) ? size.width * 0.8 : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                observacao(),
                Button(
                  buttonColor: !widget.isCanceladoFinalizado ? Colors.green : Colors.grey,
                  onPressed: () => !widget.isCanceladoFinalizado ? salvar() : null,
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  text: 'Salvar',
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          loadingBar(barraCarregamento),
          Container(
            decoration: BoxDecoration(border: Border.all(color: theme.colorScheme.primary), borderRadius: BorderRadius.circular(4)),
            width: Responsive.isLargeScreen(context) ? size.width * 0.8 : null,
            margin: EdgeInsets.all(8),
            child: AnexosTab(
              pessoaLogada: widget.pessoaLogada,
              atendimentoCarregado: widget.atendimentoCarregado,
              isModoInclusao: widget.isModoInclusao,
              isCanceladoFinalizado: widget.isCanceladoFinalizado,
            ),
          ),
        ],
      ),
    );
  }

  void _limparCampos() {
    observacaoController.clear();
  }

  void _mostrarBarraCarregamento() {
    setState(() => barraCarregamento = !barraCarregamento);
  }
}
