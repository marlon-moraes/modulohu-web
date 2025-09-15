// 🐦 Flutter imports:
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// Um arquivo que define máscaras para formatação de entradas de texto.
///
/// Este arquivo contém definições de máscaras para diferentes tipos de
/// dados, como números de carteirinha, celular, CNPJ, CPF, datas, horários,
/// e telefones. As máscaras são utilizadas para garantir que as entradas
/// do usuário estejam em um formato específico.
///
/// ## Exemplo de Uso:
/// ```dart
/// TextField(
///   inputFormatters: [mascaraCelular],
///   keyboardType: TextInputType.phone,
/// )
/// ```
///
/// ## Uso:
/// Este arquivo pode ser utilizado em qualquer parte da aplicação onde
/// seja necessário formatar entradas de texto. As máscaras ajudam a
/// melhorar a experiência do usuário, garantindo que os dados sejam
/// inseridos em um formato consistente e válido.

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
