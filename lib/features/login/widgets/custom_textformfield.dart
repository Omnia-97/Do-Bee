import 'package:DooBee/features/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:provider/provider.dart';
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
      this.onSaved, this.contentPadding,
      super.key});
  String hintText;
  Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
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
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
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
        contentPadding: widget.contentPadding ,
        border: GradientOutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          width: 1.w,
          gradient: const LinearGradient(
            colors: [
              Color(0xFFD9B8FF),
              Color(0xFFAB62FF),
            ],
          ),
        ),
        hintText: widget.hintText,
        hintStyle: theme.textTheme.bodyLarge!.copyWith(
          fontSize: 15.sp,
          fontWeight: FontWeight.w300,
          color: const Color(0xFF898989),
        ),
        enabledBorder: GradientOutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          width: 1.w,
          gradient: const LinearGradient(
            colors: [
              Color(0xFFD9B8FF),
              Color(0xFFAB62FF),
            ],
          ),
        ),
        focusedBorder:  GradientOutlineInputBorder(
          width: 1.w,
          borderRadius: BorderRadius.circular(10.r),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFD9B8FF),
              Color(0xFFAB62FF),
            ],
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
                  obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: provider.themeMode == ThemeMode.light
                      ? Colors.grey
                      : Colors.white,
                ),
              )
            : widget.suffixIcon,
      ),
    );
  }
}
