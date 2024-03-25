import 'package:flutter/material.dart';
import 'package:todo_app_new/core/config/app_theme_manager.dart';

class CustomIconText extends StatelessWidget {
  CustomIconText({required this.icon, required this.iconText});
  Widget icon;
  String iconText;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Container(
            width: 309,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFDFECDB),
              boxShadow: [
                BoxShadow(
                  color: AppThemeManager.primaryColor.withOpacity(.5),
                  blurRadius: 13,
                  offset: const Offset(0, 1),
                )
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: IconButton(
                    onPressed: () {},
                    icon: icon,
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Text(
                    iconText,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
