// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Um widget que representa um campo de texto personalizável.
///
/// O widget [FormTextField] é um campo de texto que pode ser usado em formulários.
/// Ele suporta validação, formatação de entrada, e pode ser configurado como um
/// campo de senha. Este widget é baseado no [TextFormField] do Flutter.
///
/// ## Parâmetros:
/// - [inputFormatters]: Uma lista de formatadores de entrada que podem ser aplicados ao texto.
/// - [validator]: Uma função que valida o texto inserido. Deve retornar uma string de erro ou null.
/// - [controller]: Um controlador para gerenciar o texto do campo.
/// - [onChanged]: Um callback chamado quando o texto é alterado.
/// - [onSaved]: Um callback chamado quando o campo é salvo.
/// - [margin]: Margens ao redor do campo de texto. O padrão é `EdgeInsets.all(0)`.
/// - [isPasswordField]: Um boolean que indica se o campo deve ser tratado como um campo de senha. O padrão é `false`.
/// - [focusNode]: Um [FocusNode] que pode ser usado para gerenciar o foco do campo.
/// - [enter]: Um callback chamado quando a tecla "Enter" é pressionada.
/// - [selectable]: Um boolean que indica se o campo pode ser selecionado. O padrão é `false`.
/// - [autoFocus]: Um boolean que indica se o campo deve receber foco automaticamente ao ser exibido. O padrão é `false`.
/// - [icon]: Um ícone que será exibido ao lado do campo de texto.
/// - [enabled]: Um boolean que indica se o campo está habilitado. O padrão é `true`.
/// - [border]: Um boolean que indica se o campo deve ter uma borda. O padrão é `true`.
/// - [hint]: Um texto de dica que será exibido quando o campo estiver vazio.
/// - [text]: O texto do rótulo que será exibido acima do campo.
///
/// ## Exemplo:
/// ```dart
/// FormTextField(
///   controller: TextEditingController(),
///   text: 'Nome',
///   hint: 'Digite seu nome',
///   isPasswordField: false,
///   onChanged: (value) {
///     // Ação ao alterar o texto
///   },
///   validator: (value) {
///     if (value == null || value.isEmpty) {
///       return 'Campo obrigatório';
///     }
///     return null;
///   },
/// )
/// ```
///
/// ## Uso:
/// Este widget pode ser usado em qualquer parte da aplicação onde um campo de texto
/// é necessário. Ele fornece uma maneira flexível de criar campos de texto com
/// suporte a validação, formatação e personalização.
class FormTextField extends StatefulWidget {
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final EdgeInsetsGeometry? margin;
  final bool? isPasswordField;
  final FocusNode? focusNode;
  final VoidCallback? enter;
  final bool selectable;
  final bool autoFocus;
  final IconData? icon;
  final bool enabled;
  final bool? border;
  final String? hint;
  final String text;

  const FormTextField({
    super.key,
    this.margin = const EdgeInsets.all(0),
    this.isPasswordField = false,
    this.controller,
    this.hint,
    this.icon,
    this.inputFormatters,
    required this.text,
    this.border = true,
    this.focusNode,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.onSaved,
    this.enter,
    this.autoFocus = false,
    this.selectable = false,
  });

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  bool _showText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: widget.margin,
      child: TextFormField(
        decoration: InputDecoration(
          suffixIcon:
              widget.isPasswordField!
                  ? IconButton(
                    icon: Icon(_showText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _showText = !_showText),
                    tooltip: _showText ? 'Mostrar Senha' : 'Ocultar Senha',
                    padding: EdgeInsets.zero,
                  )
                  : widget.icon != null
                  ? Icon(widget.icon)
                  : null,
          border: widget.border! ? const OutlineInputBorder() : null,
          contentPadding: const EdgeInsets.all(10),
          labelStyle: theme.textTheme.bodyMedium,
          labelText: widget.text,
          hintText: widget.hint,
          isDense: true,
        ),
        enabled: widget.enabled || (widget.selectable && !widget.enabled),
        obscureText: widget.isPasswordField! ? _showText : false,
        style: const TextStyle(overflow: TextOverflow.ellipsis),
        readOnly: widget.selectable && !widget.enabled,
        enableInteractiveSelection: widget.selectable,
        inputFormatters: widget.inputFormatters,
        textInputAction: TextInputAction.next,
        onEditingComplete: widget.enter,
        controller: widget.controller,
        autofocus: widget.autoFocus,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        validator: widget.validator,
        onSaved: widget.onSaved,
      ),
    );
  }
}
