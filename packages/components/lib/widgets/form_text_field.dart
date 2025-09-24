part of '../components.dart';

/// Um widget que representa um campo de texto personalizável.
///
/// O widget [FormTextField] é um campo de texto que pode ser usado em formulários.
/// Ele suporta validação, formatação de entrada, múltiplas linhas, e pode ser configurado como um
/// campo de senha. Este widget é baseado no [TextFormField] do Flutter.
///
/// ## Parâmetros:
/// - [inputFormatters]: Lista de formatadores de entrada aplicados ao texto.
/// - [validator]: Função que valida o texto inserido. Deve retornar uma string de erro ou null.
/// - [controller]: Controlador para gerenciar o texto do campo.
/// - [onChanged]: Callback chamado quando o texto é alterado.
/// - [onSaved]: Callback chamado quando o campo é salvo.
/// - [margin]: Margens ao redor do campo de texto. O padrão é `EdgeInsets.all(0)`.
/// - [isPasswordField]: Booleano que indica se o campo deve ser tratado como senha. O padrão é `false`.
/// - [focusNode]: [FocusNode] para gerenciar o foco do campo.
/// - [selectable]: Booleano que indica se o campo pode ser selecionado. O padrão é `false`.
/// - [autoFocus]: Booleano que indica se o campo deve receber foco automaticamente ao ser exibido. O padrão é `false`.
/// - [icon]: Ícone exibido ao lado do campo de texto.
/// - [enabled]: Booleano que indica se o campo está habilitado. O padrão é `true`.
/// - [border]: Booleano que indica se o campo deve ter uma borda. O padrão é `true`.
/// - [hint]: Texto de dica exibido quando o campo está vazio.
/// - [text]: Texto do rótulo exibido acima do campo.
/// - [maxLines]: Número máximo de linhas do campo. O padrão é 1.
///
/// ## Exemplo:
/// ```dart
/// FormTextField(
///   controller: TextEditingController(),
///   text: 'Nome',
///   hint: 'Digite seu nome',
///   isPasswordField: false,
///   maxLines: 1,
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
/// suporte a validação, formatação, múltiplas linhas e personalização visual.
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
  final int? maxLines;

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
    this.maxLines = 1,
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
          suffixIcon: widget.isPasswordField!
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
        maxLines: widget.maxLines,
      ),
    );
  }
}
