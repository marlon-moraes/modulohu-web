part of '../components.dart';

/// Um widget que exibe um dialog de alerta com conteúdo personalizável.
///
/// O widget [Alert] é um widget com estado que apresenta um dialog modal
/// com um cabeçalho, conteúdo e um botão de ação. Pode ser usado para mostrar
/// mensagens de sucesso ou aviso, juntamente com qualquer conteúdo personalizado
/// fornecido pelo usuário.
///
/// O dialog pode ser configurado para exibir um cabeçalho, um título de sucesso ou
/// aviso, e um botão para fechar o dialog.
///
/// ## Parâmetros:
/// - [buttonColor]: A cor do botão de ação. O padrão é `Colors.blueAccent`.
/// - [buttonText]: O texto exibido no botão de ação. O padrão é `'Fechar'`.
/// - [success]: Um boolean que indica se o alerta é uma mensagem de sucesso. Se verdadeiro, o título exibirá "SUCESSO". Se falso, exibirá "ATENÇÃO".
/// - [header]: Uma string que representa o cabeçalho do dialog de alerta. Se vazio, um título padrão será mostrado com base no parâmetro [success].
/// - [title]: Um boolean que indica se o cabeçalho deve ser exibido como um título. O padrão é `false`.
/// - [isModal]: Um boolean que indica se o dialog é modal. Se verdadeiro, o dialog terá uma cor de fundo secundária.
/// - [child]: Um widget que representa o conteúdo principal do dialog de alerta. Este é um parâmetro obrigatório.
///
/// ## Exemplo:
/// ```dart
/// Alert(
///   buttonText: 'OK',
///   buttonColor: Colors.green,
///   success: true,
///   header: 'Operação concluída',
///   isModal: true,
///   child: Text('A operação foi realizada com sucesso!'),
/// )
/// ```
///
/// ## Uso:
/// Este widget pode ser usado em qualquer parte da aplicação onde um dialog
/// de alerta é necessário. Ele fornece uma maneira flexível de exibir mensagens e
/// conteúdo personalizado para o usuário.
class Alert extends StatefulWidget {
  final Color? buttonColor;
  final String? buttonText;
  final bool? success;
  final String? header;
  final bool? title;
  final bool isModal;
  final Widget child;

  const Alert({
    super.key,
    this.buttonText = 'Fechar',
    this.buttonColor = Colors.blueAccent,
    this.success,
    this.title,
    this.header = '',
    required this.isModal,
    required this.child,
  });

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5)),
          color: widget.isModal ? theme.colorScheme.secondary : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: widget.header!.isEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.success == true)
                    Text(
                      'SUCESSO',
                      style: TextStyle(color: theme.colorScheme.secondary, fontWeight: FontWeight.bold),
                    ),
                  if (widget.success == false)
                    Text(
                      'ATENÇÃO',
                      style: TextStyle(color: theme.colorScheme.error, fontWeight: FontWeight.bold),
                    ),
                  const SizedBox(),
                  if (widget.title == true) CloseButton(onPressed: () => Navigator.pop(context), color: theme.colorScheme.error),
                ],
              )
            : Text(
                widget.header!,
                style: TextStyle(color: widget.isModal ? theme.colorScheme.onSecondary : theme.colorScheme.onSurface),
                textAlign: widget.isModal ? TextAlign.center : TextAlign.start,
              ),
      ),
      titlePadding: const EdgeInsets.all(8),
      content: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        radius: Radius.zero,
        interactive: true,
        child: SizedBox(
          child: SingleChildScrollView(controller: scrollController, child: widget.child),
        ),
      ),
      actions: [
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Button(
              contentColor: theme.colorScheme.onPrimary,
              onPressed: () => Navigator.pop(context),
              buttonColor: widget.buttonColor,
              text: widget.buttonText,
            ),
          ],
        ),
      ],
      surfaceTintColor: theme.colorScheme.surface,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
