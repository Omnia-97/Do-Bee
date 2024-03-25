import 'package:flutter/material.dart';
import '../../../core/config/app_theme_manager.dart';

class CustomTextFormFieldRegister extends StatefulWidget {
  CustomTextFormFieldRegister(
      {required this.hintText,
      this.suffixIcon,
      this.isPassword,
      this.controller,
      this.keyboardType,
      this.onTap,
      this.onChanged,
      this.onValidate,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.onSaved,
      super.key});
  String hintText;
  Widget? suffixIcon;
  final bool? isPassword;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function()? onTap, onEditingComplete;
  final void Function(String?)? onChanged, onFieldSubmitted, onSaved;
  final String? Function(String?)? onValidate;

  @override
  State<CustomTextFormFieldRegister> createState() =>
      _CustomTextFormFieldRegisterState();
}

class _CustomTextFormFieldRegisterState
    extends State<CustomTextFormFieldRegister> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      validator: widget.onValidate,
      onSaved: widget.onSaved,
      onFieldSubmitted: widget.onFieldSubmitted,
      onEditingComplete: widget.onEditingComplete,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ?? false ? obscureText : !obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
        enabledBorder:
            const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppThemeManager.primaryColor,
            width: 2.5,
          ),
        ),
        suffixIcon: widget.isPassword ?? false
            ? InkWell(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : widget.suffixIcon,
      ),
    );
  }
}
