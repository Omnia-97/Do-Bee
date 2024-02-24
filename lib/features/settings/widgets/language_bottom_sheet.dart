import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_new/config/constants/app_theme_manager.dart';
import '../../settings_provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    String language = provider.languageCode;
    var appLocalization = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 24),
      child: Column(
        children: [
          RadioListTile(
            activeColor: AppThemeManager.primaryColor,
            title: Text(
              appLocalization.english,
              style: GoogleFonts.elMessiri(
                fontSize: 30,
                color: language == 'en'
                    ? AppThemeManager.primaryColor
                    : AppThemeManager.blackColor,
              ),
            ),
            value: 'en',
            groupValue: language,
            onChanged: (val) {
              language = val!;
              provider.changeLanguage('en');
            },
          ),
          RadioListTile(
              activeColor: AppThemeManager.primaryColor,
              selectedTileColor: AppThemeManager.primaryColor,
              title: Text(
                appLocalization.arabic,
                style: GoogleFonts.elMessiri(
                  fontSize: 30,
                  color: language == 'ar'
                      ? AppThemeManager.primaryColor
                      : AppThemeManager.blackColor,
                ),
              ),
              value: 'ar',
              groupValue: language,
              onChanged: (val) {
                language = val!;
                provider.changeLanguage('ar');
              }),
        ],
      ),
    );
  }
}
