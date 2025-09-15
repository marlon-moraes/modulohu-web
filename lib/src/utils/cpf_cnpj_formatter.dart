/// Formata uma string de CPF ou CNPJ.
///
/// A função [cpfCnpjFormatter] recebe uma string que representa um CPF
/// ou CNPJ e a formata de acordo com o padrão brasileiro. Se a string
/// não corresponder ao formato de CPF ou CNPJ, o valor original será
/// retornado.
///
/// ## Parâmetros:
/// - [valor]: A string que representa o CPF ou CNPJ a ser formatado.
///
/// ## Retorno:
/// Retorna uma string formatada no padrão:
/// - CPF: `000.000.000-00`
/// - CNPJ: `00.000.000/0000-00`
/// Se a string não for um CPF ou CNPJ válido, retorna o valor original.
///
/// ## Exemplo:
/// ```dart
/// String cpfFormatado = cpfCnpjFormatter('12345678909'); // Retorna '123.456.789-09'
/// String cnpjFormatado = cpfCnpjFormatter('12345678000195'); // Retorna '12.345.678/0001-95'
/// String valorOriginal = cpfCnpjFormatter('12345'); // Retorna '12345'
/// ```
///
/// ## Uso:
/// Esta função pode ser utilizada em qualquer parte da aplicação onde
/// seja necessário formatar CPFs ou CNPJs, como em formulários ou relatórios.
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
