// String? dropdownValidation(String? value, String type) {
//   if (value == null || value.isEmpty) {
//     return 'Campo $type deve ser informado!';
//   } else {
//     return null;
//   }
// }
// String? fieldValidation(String? value, String type) {
//   if (value == null || value.isEmpty) {
//     return 'Campo $type deve ser preenchido!';
//   } else {
//     return null;
//   }
// }
// String? listValidation(List<dynamic>? value, String type) {
//   if (value == null || value.isEmpty) {
//     return 'Selecione ao menos um $type!';
//   } else {
//     return null;
//   }
// }
// String? cpfValidation(String value) {
//   value = value.replaceAll(RegExp(r'\D'), '');
//   if (value == '00000000000' ||
//       value == '11111111111' ||
//       value == '22222222222' ||
//       value == '33333333333' ||
//       value == '44444444444' ||
//       value == '55555555555' ||
//       value == '66666666666' ||
//       value == '77777777777' ||
//       value == '88888888888' ||
//       value == '99999999999') {
//     return 'CPF inválido!';
//   }
//   int sum = 0;
//   for (var i = 0; i < 9; i++) {
//     sum += int.parse(value[i]) * (10 - i);
//   }
//   int digit1 = 11 - (sum % 11);
//   if (digit1 >= 10) digit1 = 0;
//   sum = 0;
//   for (int i = 0; i < 10; i++) {
//     sum += int.parse(value[i]) * (11 - i);
//   }
//   int digit2 = 11 - (sum % 11);
//   if (digit2 >= 10) digit2 = 0;
//   if (value.substring(9) != '$digit1$digit2') return 'CPF inválido!';
//   return null;
// }
// String? emailValidation(String? value) {
//   if (value == null || value.isEmpty) return 'Email deve ser informado!';
//   final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
//   if (!emailRegExp.hasMatch(value)) return 'Email inválido!';
//   return null;
// }
