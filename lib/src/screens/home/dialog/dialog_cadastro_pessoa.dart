// ignore_for_file: use_build_context_synchronously

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/components/components.dart';
import 'package:modulohu_web/src/models/pessoa_cadastro.dart';
import 'package:modulohu_web/src/models/pessoa_cadastro_crud.dart';
import 'package:modulohu_web/src/models/user_action.dart';
import 'package:modulohu_web/src/services/api/req/pessoa_cadastro_req.dart';

class DialogCadastroPessoa extends StatefulWidget {
  final PessoaCadastro pessoaCadastro;
  final UserAction pessoaLogada;
  final String title;

  const DialogCadastroPessoa({super.key, required this.pessoaCadastro, required this.pessoaLogada, required this.title});

  @override
  State<DialogCadastroPessoa> createState() => _DialogCadastroPessoaState();
}

class _DialogCadastroPessoaState extends State<DialogCadastroPessoa> {
  final _formKey = GlobalKey<FormState>();
  var nomeController = TextEditingController();
  var cpfController = TextEditingController();
  var cpfFocus = FocusNode();
  var telefoneController = TextEditingController();
  var emailController = TextEditingController();
  var liberarCampos = false;
  var barraCarregamento = false;
  PessoaCadastroReq pessoaCadastroReq = PessoaCadastroReq();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    var pessoa = PessoaCadastroCRUD();

    Future<void> incluirPessoa(bool prestador) async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        pessoa.idEmp = widget.pessoaLogada.usuario?.empresa?.id;
        pessoa.prestador = prestador;
        pessoa.usuAlt = UsuAlt(id: widget.pessoaLogada.unidades?.first.idUni);
        _mostrarBarraCarregamento();
        final res = await pessoaCadastroReq.reqIncluirPessoa(pessoa, context);
        if (res.nome != null && res.nome != '') {
          widget.pessoaCadastro.cpf = res.cpf;
          widget.pessoaCadastro.nome = res.nome;
          _limparCampos();
          Navigator.pop(context);
        }
        _mostrarBarraCarregamento();
      }
    }

    return SimpleDialog(
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
          color: theme.colorScheme.secondary,
        ),
        padding: EdgeInsets.all(8),
        child: Text('Cadastro de Pessoa', style: TextStyle(color: theme.colorScheme.onSecondary)),
      ),
      children: [
        SizedBox(
          width: Responsive.isLargeScreen(context) ? size.width * 0.5 : size.width,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FormTextField(
                        onChanged: (p0) async {
                          if (p0.length >= 14) {
                            final res = await pessoaCadastroReq.reqValidarPessoaCpf(p0, context);
                            if ((res.nome != null && res.nome != '') && (widget.title == 'Beneficiário' && res.prestador == 'NAO')) {
                              widget.pessoaCadastro.cpf = res.cpf;
                              widget.pessoaCadastro.nome = res.nome;
                              Navigator.pop(context);
                            } else if ((res.nome != null && res.nome != '') && (widget.title != 'Beneficiário' && res.prestador == 'SIM')) {
                              widget.pessoaCadastro.cpf = res.cpf;
                              widget.pessoaCadastro.nome = res.nome;
                              Navigator.pop(context);
                            } else {
                              setState(() => liberarCampos = true);
                            }
                          } else {
                            setState(() => liberarCampos = false);
                          }
                        },
                        enter: () => widget.title == 'Beneficiário' ? incluirPessoa(false) : incluirPessoa(true),
                        validator: (p0) => fieldValidation(p0, 'CPF'),
                        onSaved: (p0) => pessoa.cpf = p0,
                        margin: const EdgeInsets.all(8),
                        inputFormatters: [mascaraCPF],
                        controller: cpfController,
                        focusNode: cpfFocus,
                        text: 'CPF',
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: FormTextField(
                        enter: () => widget.title == 'Beneficiário' ? incluirPessoa(false) : incluirPessoa(true),
                        validator: (p0) => fieldValidation(p0, 'Nome'),
                        onSaved: (p0) => pessoa.nome = p0,
                        margin: const EdgeInsets.all(8),
                        controller: nomeController,
                        enabled: liberarCampos,
                        text: 'Nome',
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: FormTextField(
                        enter: () => widget.title == 'Beneficiário' ? incluirPessoa(false) : incluirPessoa(true),
                        validator: (p0) => emailValidation(p0),
                        onSaved: (p0) => pessoa.email = p0,
                        margin: const EdgeInsets.all(8),
                        controller: emailController,
                        enabled: liberarCampos,
                        text: 'Email',
                      ),
                    ),
                    Expanded(
                      child: FormTextField(
                        onSaved: (p0) {
                          String numbers = p0!.replaceAll(RegExp(r'\D'), '');
                          String ddd = '';
                          String numero = '';
                          if (numbers.length >= 10) {
                            ddd = numbers.substring(0, 2);
                            numero = numbers.substring(2);
                          } else if (numbers.length >= 2) {
                            ddd = numbers.substring(0, 2);
                            numero = numbers.substring(2);
                          } else {
                            numero = numbers;
                          }
                          pessoa.dddCelular = ddd;
                          pessoa.celular = numero;
                        },
                        enter: () => widget.title == 'Beneficiário' ? incluirPessoa(false) : incluirPessoa(true),
                        validator: (p0) => fieldValidation(p0, 'Telefone'),
                        inputFormatters: [mascaraCelular],
                        margin: const EdgeInsets.all(8),
                        controller: telefoneController,
                        enabled: liberarCampos,
                        text: 'Telefone',
                      ),
                    ),
                  ],
                ),
                loadingBar(barraCarregamento),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Button(
                      onPressed: () => widget.title == 'Beneficiário' ? incluirPessoa(false) : incluirPessoa(true),
                      buttonColor: Colors.green,
                      margin: EdgeInsets.all(8),
                      text: 'Incluir',
                    ),
                    Button(onPressed: () => Navigator.of(context).pop(), buttonColor: Colors.blueAccent, margin: EdgeInsets.all(8), text: 'Fechar'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    cpfController.dispose();
    cpfFocus.dispose();
    telefoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    cpfFocus.requestFocus();
  }

  void _limparCampos() {
    nomeController.clear();
    cpfController.clear();
    telefoneController.clear();
    emailController.clear();
    setState(() => liberarCampos = false);
    cpfFocus.requestFocus();
  }

  void _mostrarBarraCarregamento() {
    setState(() => barraCarregamento = !barraCarregamento);
  }
}
