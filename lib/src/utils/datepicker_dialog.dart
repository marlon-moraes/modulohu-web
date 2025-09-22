// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:intl/intl.dart';

///
/// A função [selecionarData] exibe um dialog de seleção de data e, se
/// uma data for escolhida, formata essa data e a atribui ao controlador
/// de texto fornecido.
///
/// ## Parâmetros:
/// - [controller]: Um [TextEditingController] que será atualizado com
///   a data formatada após a seleção.
/// - [isInicioDia]: Um boolean que indica se a data deve ser formatada
///   como início do dia (00:00:00) ou fim do dia (23:59:59). Se `null`,
///   a data será formatada apenas como `dd/MM/yyyy`.
/// - [context]: O contexto do widget que chama a função, necessário
///   para exibir o dialog de seleção de data.
///
/// ## Retorno:
/// Esta função não retorna um valor. Ela atualiza o texto do controlador
/// com a data formatada.
///
/// ## Exemplo:
/// ```dart
/// TextEditingController dataController = TextEditingController();
/// await selecionarData(dataController, true, context);
/// print(dataController.text); // Saída: '15/09/2025 00:00:00' (ou a data selecionada)
/// ```
///
/// ## Uso:
/// Esta função pode ser utilizada em qualquer parte da aplicação onde
/// seja necessário permitir que o usuário selecione uma data. É útil
/// em formulários e interfaces que requerem entrada de data.
Future selecionarData(TextEditingController controller, bool? isInicioDia, BuildContext context) async {
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
      finalDate =
          isInicioDia ? DateTime(picked.year, picked.month, picked.day, 0, 0, 0) : DateTime(picked.year, picked.month, picked.day, 23, 59, 59);
      formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(finalDate);
    }
    controller.text = formattedDate;
  }
}
