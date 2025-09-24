// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:components/components.dart';

class FilterField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onIconTap;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;

  const FilterField({super.key, required this.label, required this.controller, required this.onIconTap, this.enabled = false, this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(child: FormTextField(controller: controller, inputFormatters: inputFormatters, margin: EdgeInsets.all(8), text: label, enabled: enabled)),
        Container(
          margin: EdgeInsets.all(8),
          child: InkWell(
            onTap: onIconTap,
            child: Ink(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: theme.colorScheme.primary),
              child: Icon(Icons.more_horiz_outlined, color: theme.colorScheme.onPrimary),
            ),
          ),
        ),
      ],
    );
  }
}
