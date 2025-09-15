// 📦 Package imports:
import 'package:intl/intl.dart';

/// Formata uma string de data para o formato brasileiro.
///
/// A função [dateFormatter] recebe uma string que representa uma data
/// em formato ISO 8601 e a formata para o padrão brasileiro `dd/MM/yyyy HH:mm:ss`.
///
/// ## Parâmetros:
/// - [date]: A string que representa a data a ser formatada.
///
/// ## Retorno:
/// Retorna a data formatada como uma string. Se a string de entrada estiver
/// vazia, retorna uma string vazia.
///
/// ## Exemplo:
/// ```dart
/// String dataFormatada = dateFormatter('2023-09-15T10:30:00Z'); // Retorna '15/09/2023 10:30:00'
/// ```
///
/// ## Uso:
/// Esta função pode ser utilizada em qualquer parte da aplicação onde
/// seja necessário formatar datas para o padrão brasileiro.
String dateFormatter(String date) {
  if (date.isNotEmpty) {
    DateTime dateTime = DateTime.parse(date.replaceAll(RegExp(r'[+-]\d{2}:\d{2}'), ''));
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
  }
  return '';
}

/// Formata uma string de data para o formato especificado.
///
/// A função [dateFormatter2] recebe uma string que representa uma data
/// e um booleano que indica se o tempo deve ser incluído no formato.
/// Retorna a data formatada no formato `yyyy-MM-dd` ou `yyyy-MM-dd HH:mm:ss`.
///
/// ## Parâmetros:
/// - [date]: A string que representa a data a ser formatada.
/// - [withTime]: Um booleano que indica se o tempo deve ser incluído
///   na formatação. Se verdadeiro, o formato será `yyyy-MM-dd HH:mm:ss`.
///   Se falso, o formato será `yyyy-MM-dd`.
///
/// ## Retorno:
/// Retorna a data formatada como uma string. Se a string de entrada estiver
/// vazia, retorna uma string vazia.
///
/// ## Exemplo:
/// ```dart
/// String dataFormatadaComTempo = dateFormatter2('2023-09-15T10:30:00Z', true); // Retorna '2023-09-15 10:30:00'
/// String dataFormatadaSemTempo = dateFormatter2('2023-09-15T10:30:00Z', false); // Retorna '2023-09-15'
/// ```
///
/// ## Uso:
/// Esta função pode ser utilizada em qualquer parte da aplicação onde
/// seja necessário formatar datas em diferentes padrões.
String dateFormatter2(String date, bool withTime) {
  if (date.isNotEmpty) {
    DateTime dateTime = DateFormat('dd/MM/yyyy HH:mm:ss').parse(date.replaceAll(RegExp(r'[+-]\d{2}:\d{2}'), ''));
    return DateFormat(withTime ? 'yyyy-MM-dd HH:mm:ss' : 'yyyy-MM-dd').format(dateTime);
  }
  return '';
}
