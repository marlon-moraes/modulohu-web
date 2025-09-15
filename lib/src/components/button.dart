// 🐦 Flutter imports:
import 'package:flutter/material.dart';

/// Um widget que representa um botão personalizável.
///
/// O widget [Button] é um botão que pode conter ícones e texto. Ele permite
/// personalizar a cor do botão, a cor do conteúdo, margens, e ícones à esquerda
/// e à direita do texto. Este botão é baseado no widget [ElevatedButton].
///
/// ## Parâmetros:
/// - [margin]: Margens ao redor do botão. O padrão é `EdgeInsets.all(0)`.
/// - [onPressed]: Callback que é chamado quando o botão é pressionado. Este parâmetro é obrigatório.
/// - [contentColor]: A cor do texto e dos ícones dentro do botão.
/// - [buttonColor]: A cor de fundo do botão.
/// - [iconColor]: A cor dos ícones, se não especificada, será usada a cor do conteúdo.
/// - [rightIcon]: Um ícone que será exibido à direita do texto.
/// - [leftIcon]: Um ícone que será exibido à esquerda do texto.
/// - [focus]: Um [FocusNode] que pode ser usado para gerenciar o foco do botão.
/// - [height]: A altura do botão.
/// - [width]: A largura do botão.
/// - [text]: O texto a ser exibido no botão.
///
/// ## Exemplo:
/// ```dart
/// Button(
///   onPressed: () {
///     // Ação ao pressionar o botão
///   },
///   text: 'Clique Aqui',
///   buttonColor: Colors.blue,
///   contentColor: Colors.white,
///   leftIcon: Icons.add,
///   rightIcon: Icons.arrow_forward,
/// )
/// ```
///
/// ## Uso:
/// Este widget pode ser usado em qualquer parte da aplicação onde um botão
/// é necessário. Ele fornece uma maneira flexível de criar botões com ícones
/// e texto, permitindo personalização de estilo e comportamento.
class Button extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final VoidCallback onPressed;
  final Color? contentColor;
  final IconData? rightIcon;
  final Color? buttonColor;
  final IconData? leftIcon;
  final Color? iconColor;
  final FocusNode? focus;
  final double? height;
  final double? width;
  final String? text;

  const Button({
    super.key,
    this.margin = const EdgeInsets.all(0),
    required this.onPressed,
    this.contentColor,
    this.buttonColor,
    this.iconColor,
    this.rightIcon,
    this.leftIcon,
    this.height,
    this.focus,
    this.width,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: buttonColor, foregroundColor: contentColor),
        onPressed: onPressed,
        focusNode: focus,
        child: Row(
          children: [
            if (leftIcon != null) Icon(leftIcon, color: iconColor ?? contentColor),
            if (text != null) Text(' $text', style: TextStyle(color: contentColor)),
            if (rightIcon != null) Icon(rightIcon, color: iconColor ?? contentColor),
          ],
        ),
      ),
    );
  }
}
