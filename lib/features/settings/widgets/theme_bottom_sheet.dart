import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_new/config/constants/app_theme_manager.dart';

import '../../settings_provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    ThemeMode theme = provider.themeMode;
    var appLocalization =AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 24),
      child: Column(
        children: [
          RadioListTile(
            activeColor: AppThemeManager.primaryColor,
            title: Text(
              "Light",
              style: GoogleFonts.elMessiri(
                fontSize: 30,
                color: theme == ThemeMode.light
                    ? AppThemeManager.primaryColor
                    : AppThemeManager.darkPrimaryColor,
              ),
            ),
            value: ThemeMode.light,
            groupValue: theme,
            onChanged: (val) {
              theme = val!;
              provider.changeThemeMode(ThemeMode.light);
            },
          ),
          RadioListTile(
              activeColor: AppThemeManager.primaryColor,
              title: Text(
                appLocalization.dark,
                style: GoogleFonts.elMessiri(
                  fontSize: 30,
                  color: theme == ThemeMode.dark
                      ? AppThemeManager.primaryColor
                      : AppThemeManager.blackColor,
                ),
              ),
              value: ThemeMode.dark,
              groupValue: theme,
              onChanged: (val) {
                theme = val!;
                provider.changeThemeMode(ThemeMode.dark);
              }),
        ],
      ),
    );
  }
}
