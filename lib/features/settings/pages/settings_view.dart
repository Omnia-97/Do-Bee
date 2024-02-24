import 'package:flutter/material.dart';
import 'package:todo_app_new/config/constants/app_theme_manager.dart';
import 'package:todo_app_new/config/widgets/container_appBar_widget.dart';
import '../widgets/language_bottom_sheet.dart';
import '../widgets/theme_bottom_sheet.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    //var provider = Provider.of<MyProvider>(context);
    //var appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContainerAppBarWidget(text: 'Settings'),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
              "Language",
              style: theme.bodyLarge,
            ),
              const SizedBox(
                height: 10,
              ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return const SizedBox(
                        height: 580,
                        child: LanguageBottomSheet(),
                      );
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                width: 319,
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppThemeManager.primaryColor,
                  ),
                ),
                child: Text(
                  'English',
                  style: theme.bodyMedium,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Theme",
              style: theme.bodyLarge,
            ),
              const SizedBox(
                height: 10,
              ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return const SizedBox(
                        height: 460,
                        child: ThemeBottomSheet(),
                      );
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                width: 319,
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppThemeManager.primaryColor,
                  ),
                ),
                child: Text(
                  'Light',
                  style: theme.bodyMedium,
                ),
              ),
            ),
          ],),
        ),

      ],
    );
  }
}
