// String dateFormatter(String date) {
//   if (date.isNotEmpty) {
//     DateTime dateTime = DateTime.parse(date.replaceAll(RegExp(r'[+-]\d{2}:\d{2}'), ''));
//     return DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
//   }
//   return '';
// }

// String dateFormatter2(String date, bool withTime) {
//   if (date.isNotEmpty) {
//     DateTime dateTime = DateFormat('dd/MM/yyyy HH:mm:ss').parse(date.replaceAll(RegExp(r'[+-]\d{2}:\d{2}'), ''));
//     return DateFormat(withTime ? 'yyyy-MM-dd HH:mm:ss' : 'yyyy-MM-dd').format(dateTime);
//   }
//   return '';
// }
