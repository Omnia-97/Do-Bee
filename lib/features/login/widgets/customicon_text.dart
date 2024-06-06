import 'package:DooBee/core/config/app_theme_manager.dart';
import 'package:DooBee/features/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CustomIconText extends StatelessWidget {
  CustomIconText({super.key, required this.icon, required this.iconText});
  Widget icon;
  String iconText;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Container(
            width: 309,
            height: 45,
            decoration: BoxDecoration(
              color: provider.themeMode == ThemeMode.light
                  ? const Color(0xFFDFECDB)
                  : AppThemeManager.darkSecondColor,
              boxShadow: [
                BoxShadow(
                  color: provider.themeMode == ThemeMode.light
                      ? AppThemeManager.primaryColor.withOpacity(.5)
                      : AppThemeManager.darkPrimaryColor.withOpacity(.1),
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
