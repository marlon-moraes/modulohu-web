// 🐦 Flutter imports:
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
