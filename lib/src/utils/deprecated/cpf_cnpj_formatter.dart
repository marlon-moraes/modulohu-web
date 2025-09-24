// String cpfCnpjFormatter(String valor) {
//   final digits = valor.replaceAll(RegExp(r'\D'), '');
//   if (digits.length == 11) {
//     // CPF: 000.000.000-00
//     return '${digits.substring(0, 3)}.${digits.substring(3, 6)}.${digits.substring(6, 9)}-${digits.substring(9, 11)}';
//   } else if (digits.length == 14) {
//     // CNPJ: 00.000.000/0000-00
//     return '${digits.substring(0, 2)}.${digits.substring(2, 5)}.${digits.substring(5, 8)}/${digits.substring(8, 12)}-${digits.substring(12, 14)}';
//   } else {
//     // Retorna o valor original se não for CPF nem CNPJ
//     return valor;
//   }
// }
