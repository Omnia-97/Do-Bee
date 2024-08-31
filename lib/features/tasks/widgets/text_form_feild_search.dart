import 'package:DooBee/features/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:provider/provider.dart';

class CustomTextFormFieldSearch extends StatefulWidget {
  CustomTextFormFieldSearch(
      {this.suffixIcon,
      this.isPassword,
      this.controller,
      this.keyboardType,
      this.onTap,
      this.onChanged,
      this.onValidate,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.onSaved,
      this.contentPadding,
      super.key});

  Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isPassword;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function()? onTap, onEditingComplete;
  final void Function(String?)? onChanged, onFieldSubmitted, onSaved;
  final String? Function(String?)? onValidate;

  @override
  State<CustomTextFormFieldSearch> createState() =>
      _CustomTextFormFieldSearchState();
}

class _CustomTextFormFieldSearchState extends State<CustomTextFormFieldSearch> {
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
          contentPadding: EdgeInsets.only(left: 18.w),
          border: GradientOutlineInputBorder(
            borderRadius: BorderRadius.circular(35.r),
            width: 1.w,
            gradient: const LinearGradient(
              colors: [
                Color(0xFFD9B8FF),
                Color(0xFFAB62FF),
              ],
            ),
          ),
          hintText: "Search task....",
          hintStyle: theme.textTheme.bodyLarge!.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w300,
            color: const Color(0xFF898989),
          ),
          enabledBorder: GradientOutlineInputBorder(
            borderRadius: BorderRadius.circular(35.r),
            width: 1.w,
            gradient: const LinearGradient(
              colors: [
                Color(0xFFD9B8FF),
                Color(0xFFAB62FF),
              ],
            ),
          ),
          focusedBorder: GradientOutlineInputBorder(
            width: 1.w,
            borderRadius: BorderRadius.circular(35.r),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFD9B8FF),
                Color(0xFFAB62FF),
              ],
            ),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(top: 11.h, bottom: 12.h, right: 4.w),
            child: SvgPicture.asset(
              provider.themeMode == ThemeMode.light
                  ? "assets/images/ic_search_light.svg"
                  : "assets/images/dark_theme/ic_search_dark.svg",
            ),
          )),
    );
  }
}
