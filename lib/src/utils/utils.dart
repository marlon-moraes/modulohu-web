// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/utils/shared_pref.dart';

/// Classe utilitária com funções e máscaras para uso geral na aplicação.
///
/// A classe [Utils] centraliza máscaras de formatação, validações de campos,
/// formatação de datas, funções de logout, seleção de datas e validação de login.
///
/// ## Propriedades:
/// - [mascaraCarteirinha]: Máscara para números de carteirinha.
/// - [mascaraCelular]: Máscara para números de celular.
/// - [mascaraCNPJ]: Máscara para números de CNPJ.
/// - [mascaraCPF]: Máscara para números de CPF.
/// - [mascaraData]: Máscara para datas.
/// - [mascaraHora]: Máscara para horários.
/// - [mascaraDataHora]: Máscara para datas com hora.
/// - [mascaraTelefone]: Máscara para números de telefone.
/// - [onlyNumbers]: Permite apenas a entrada de números.
///
/// ## Métodos:
///
/// ### cpfCnpjFormatter
/// Formata uma string como CPF ou CNPJ, conforme o tamanho.
///
/// ### cpfValidation
/// Valida um CPF, retornando uma mensagem de erro ou `null`.
///
/// ### dateFormatter
/// Formata uma string de data para o padrão brasileiro `dd/MM/yyyy HH:mm:ss`.
///
/// ### dateFormatter2
/// Formata uma string de data para `yyyy-MM-dd` ou `yyyy-MM-dd HH:mm:ss`.
///
/// ### dropdownValidation
/// Valida se um valor de dropdown foi informado.
///
/// ### emailValidation
/// Valida se um e-mail é válido.
///
/// ### fieldValidation
/// Valida se um campo de texto foi preenchido.
///
/// ### listValidation
/// Valida se uma lista possui ao menos um item selecionado.
///
/// ### logout
/// Realiza o logout do usuário, limpando as preferências e redirecionando para a tela inicial.
///
/// ### dateSelector
/// Exibe um seletor de data e preenche o controlador com a data formatada.
///
/// ### logonValidation
/// Verifica se o usuário está logado, retornando um `Future<bool>`.
///
/// ## Exemplo de Uso:
/// ```dart
/// final utils = Utils();
/// String cpfFormatado = utils.cpfCnpjFormatter('12345678909');
/// String? erro = utils.cpfValidation('123.456.789-09');
/// await utils.dateSelector(controller, true, context);
/// bool logado = await utils.logonValidation();
/// ```
class Utils {
  final _sharedPref = SharedPref();

  /// Define uma máscara para formatação de números de carteirinha.
  final mascaraCarteirinha = MaskTextInputFormatter(filter: {'#': RegExp(r'[0-9]')}, mask: '# ### ############ #');

  /// Define uma máscara para formatação de números de celular.
  final mascaraCelular = MaskTextInputFormatter(filter: {'#': RegExp(r'[0-9]')}, mask: '(##)#####-####');

  /// Define uma máscara para formatação de números de CNPJ.
  final mascaraCNPJ = MaskTextInputFormatter(filter: {'#': RegExp(r'[0-9]')}, mask: '##.###.###/####-##');

  /// Define uma máscara para formatação de números de CPF.
  final mascaraCPF = MaskTextInputFormatter(filter: {'#': RegExp(r'[0-9]')}, mask: '###.###.###-##');

  /// Define uma máscara para formatação de datas.
  final mascaraData = MaskTextInputFormatter(filter: {'#': RegExp(r'[0-9]')}, mask: '##/##/####');

  /// Define uma máscara para formatação de horários.
  final mascaraHora = MaskTextInputFormatter(filter: {'#': RegExp(r'[0-9]')}, mask: '##:##');

  /// Define uma máscara para formatação de datas com hora.
  final mascaraDataHora = MaskTextInputFormatter(filter: {'#': RegExp(r'[0-9]')}, mask: '##/##/#### ##:##:##');

  /// Define uma máscara para formatação de números de telefone.
  final mascaraTelefone = MaskTextInputFormatter(filter: {'#': RegExp(r'[0-9]')}, mask: '(##)####-####');

  /// Permite apenas a entrada de números.
  final onlyNumbers = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  String cpfCnpjFormatter(String valor) {
    final digits = valor.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 11) {
      // CPF: 000.000.000-00
      return '${digits.substring(0, 3)}.${digits.substring(3, 6)}.${digits.substring(6, 9)}-${digits.substring(9, 11)}';
    } else if (digits.length == 14) {
      // CNPJ: 00.000.000/0000-00
      return '${digits.substring(0, 2)}.${digits.substring(2, 5)}.${digits.substring(5, 8)}/${digits.substring(8, 12)}-${digits.substring(12, 14)}';
    } else {
      // Retorna o valor original se não for CPF nem CNPJ
      return valor;
    }
  }

  String? cpfValidation(String value) {
    value = value.replaceAll(RegExp(r'\D'), '');
    if (value == '00000000000' ||
        value == '11111111111' ||
        value == '22222222222' ||
        value == '33333333333' ||
        value == '44444444444' ||
        value == '55555555555' ||
        value == '66666666666' ||
        value == '77777777777' ||
        value == '88888888888' ||
        value == '99999999999') {
      return 'CPF inválido!';
    }
    int sum = 0;
    for (var i = 0; i < 9; i++) {
      sum += int.parse(value[i]) * (10 - i);
    }
    int digit1 = 11 - (sum % 11);
    if (digit1 >= 10) digit1 = 0;
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(value[i]) * (11 - i);
    }
    int digit2 = 11 - (sum % 11);
    if (digit2 >= 10) digit2 = 0;
    if (value.substring(9) != '$digit1$digit2') return 'CPF inválido!';
    return null;
  }

  String dateFormatter(String date) {
    if (date.isNotEmpty) {
      DateTime dateTime = DateTime.parse(date.replaceAll(RegExp(r'[+-]\d{2}:\d{2}'), ''));
      return DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
    }
    return '';
  }

  String dateFormatter2(String date, bool withTime) {
    if (date.isNotEmpty) {
      DateTime dateTime = DateFormat('dd/MM/yyyy HH:mm:ss').parse(date.replaceAll(RegExp(r'[+-]\d{2}:\d{2}'), ''));
      return DateFormat(withTime ? 'yyyy-MM-dd HH:mm:ss' : 'yyyy-MM-dd').format(dateTime);
    }
    return '';
  }

  String? dropdownValidation(String? value, String type) {
    if (value == null || value.isEmpty) {
      return 'Campo $type deve ser informado!';
    } else {
      return null;
    }
  }

  String? emailValidation(String? value) {
    if (value == null || value.isEmpty) return 'Email deve ser informado!';
    final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value)) return 'Email inválido!';
    return null;
  }

  String? fieldValidation(String? value, String type) {
    if (value == null || value.isEmpty) {
      return 'Campo $type deve ser preenchido!';
    } else {
      return null;
    }
  }

  String? listValidation(List<dynamic>? value, String type) {
    if (value == null || value.isEmpty) {
      return 'Selecione ao menos um $type!';
    } else {
      return null;
    }
  }

  void logout(BuildContext context) {
    _sharedPref.reset();
    context.replace('/');
  }

  Future dateSelector(TextEditingController controller, bool? isInicioDia, BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDate: DateTime.now(),
      cancelText: 'Cancelar',
      context: context,
    );
    if (picked != null) {
      DateTime finalDate = picked;
      String formattedDate = DateFormat('dd/MM/yyyy').format(finalDate);
      if (isInicioDia != null) {
        finalDate = isInicioDia ? DateTime(picked.year, picked.month, picked.day, 0, 0, 0) : DateTime(picked.year, picked.month, picked.day, 23, 59, 59);
        formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(finalDate);
      }
      controller.text = formattedDate;
    }
  }

  Future<bool> logonValidation() async {
    final retorno = await _sharedPref.read('pessoaLogada');
    if (retorno != null) return true;
    return false;
  }
}
