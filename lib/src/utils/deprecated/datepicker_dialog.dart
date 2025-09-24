// Future selecionarData(TextEditingController controller, bool? isInicioDia, BuildContext context) async {
//   final DateTime? picked = await showDatePicker(
//     initialEntryMode: DatePickerEntryMode.calendarOnly,
//     firstDate: DateTime(DateTime.now().year - 100),
//     lastDate: DateTime(DateTime.now().year + 1),
//     initialDate: DateTime.now(),
//     cancelText: 'Cancelar',
//     context: context,
//   );
//   if (picked != null) {
//     DateTime finalDate = picked;
//     String formattedDate = DateFormat('dd/MM/yyyy').format(finalDate);
//     if (isInicioDia != null) {
//       finalDate = isInicioDia ? DateTime(picked.year, picked.month, picked.day, 0, 0, 0) : DateTime(picked.year, picked.month, picked.day, 23, 59, 59);
//       formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(finalDate);
//     }
//     controller.text = formattedDate;
//   }
// }
