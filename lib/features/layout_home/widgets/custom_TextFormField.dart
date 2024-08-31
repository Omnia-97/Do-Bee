import 'package:flutter/material.dart';

import '../../../core/config/app_theme_manager.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    required this.hintText,
    super.key,
    this.controller,
    this.onValidate,
    this.onChanged,
    this.initialValue,
  });

  String hintText;
  TextEditingController? controller;
  final String? Function(String?)? onValidate;
  final void Function(String?)? onChanged;
  final String? initialValue;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextFormField(
      controller: widget.controller,
      validator: widget.onValidate,
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppThemeManager.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppThemeManager.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppThemeManager.primaryColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppThemeManager.primaryColor),
        ),
        hintText: widget.hintText,
        hintStyle: theme.textTheme.displayLarge
            ?.copyWith(color: const Color(0xFFA9A9A9), fontSize: 20),
      ),
    );
  }
}
