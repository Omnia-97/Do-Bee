import 'package:flutter/material.dart';
import 'package:todo_app_new/config/constants/app_theme_manager.dart';

class ContainerAppBarWidget extends StatelessWidget {
  ContainerAppBarWidget({required this.text, super.key});
  String text;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Container(
      width: mediaQuery.width,
      height: mediaQuery.height * 0.2,
      color: AppThemeManager.primaryColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
        vertical: 70,
      ),
      child: Text(
        text,
        style: theme.textTheme.titleLarge,
      ),
    );
  }
}
