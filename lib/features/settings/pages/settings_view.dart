import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/config/app_theme_manager.dart';
import '../../../core/widgets/container_appBar_widget.dart';
import '../../settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<MyProvider>(context);
    var appLocalizations = AppLocalizations.of(context)!;
    bool isTextDirectionRTL = Directionality.of(context) == TextDirection.rtl;
    List<String> languagesList = [
      appLocalizations.english,
      appLocalizations.arabic
    ];

    List<String> themeList = [
      appLocalizations.dark,
      appLocalizations.light,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isTextDirectionRTL
            ? Stack(
                alignment: Alignment.centerLeft,
                children: [
                  ContainerAppBarWidget(text: appLocalizations.settings),
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Text(
                      '${appLocalizations.dearUser} , \n${provider.userModel?.fullName ?? "Unknown"} ',
                      style: theme.titleLarge,
                    ),
                  ),
                ],
              )
            : Stack(
                alignment: Alignment.centerRight,
                children: [
                  ContainerAppBarWidget(text: appLocalizations.settings),
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Text(
                      '${appLocalizations.dearUser} ,\n${provider.userModel?.fullName?? 'Unknown'} ',
                      overflow: TextOverflow.ellipsis,
                      style: theme.titleLarge,
                    ),
                  ),
                ],
              ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                appLocalizations.language,
                style: theme.bodyLarge!.copyWith(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDropdown(
                  initialItem: provider.languageCode == 'en'
                      ? appLocalizations.english
                      : appLocalizations.arabic,
                  items: languagesList,
                  decoration: CustomDropdownDecoration(
                    closedSuffixIcon: const ImageIcon(
                      AssetImage('assets/images/arrow_down.png'),
                      color: AppThemeManager.primaryColor,
                    ),
                    expandedSuffixIcon: const ImageIcon(
                      AssetImage('assets/images/arrow_down.png'),
                      color: AppThemeManager.primaryColor,
                    ),
                    closedBorderRadius: BorderRadius.zero,
                    expandedBorderRadius: BorderRadius.zero,
                    closedFillColor: provider.changeCardColor(),
                    expandedFillColor: provider.changeCardColor(),
                    listItemStyle: theme.bodyMedium!
                        .copyWith(color: AppThemeManager.primaryColor),
                    headerStyle: theme.bodyMedium!
                        .copyWith(color: AppThemeManager.primaryColor),
                    closedBorder:
                        Border.all(color: AppThemeManager.primaryColor),
                  ),
                  onChanged: (value) {
                    if (value == appLocalizations.english) {
                      provider.changeLanguage('en');
                    } else if (value == appLocalizations.arabic) {
                      provider.changeLanguage('ar');
                    }
                  }),
              const SizedBox(
                height: 16,
              ),
              Text(
                appLocalizations.theme,
                style: theme.bodyLarge!.copyWith(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDropdown(
                  initialItem: provider.themeMode == ThemeMode.light
                      ? appLocalizations.light
                      : appLocalizations.dark,
                  items: themeList,
                  decoration: CustomDropdownDecoration(
                    closedSuffixIcon: const ImageIcon(
                      AssetImage('assets/images/arrow_down.png'),
                      color: AppThemeManager.primaryColor,
                    ),
                    expandedSuffixIcon: const ImageIcon(
                      AssetImage('assets/images/arrow_down.png'),
                      color: AppThemeManager.primaryColor,
                    ),
                    closedBorderRadius: BorderRadius.zero,
                    expandedBorderRadius: BorderRadius.zero,
                    closedFillColor: provider.changeLogoutColor(),
                    expandedFillColor: provider.changeCardColor(),
                    listItemStyle: theme.bodyMedium!
                        .copyWith(color: AppThemeManager.primaryColor),
                    headerStyle: theme.bodyMedium!
                        .copyWith(color: AppThemeManager.primaryColor),
                    closedBorder:
                        Border.all(color: AppThemeManager.primaryColor),
                  ),
                  onChanged: (value) {
                    if (value == appLocalizations.dark) {
                      provider.changeThemeMode(ThemeMode.dark);
                    } else if (value == appLocalizations.light) {
                      provider.changeThemeMode(ThemeMode.light);
                    }
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
