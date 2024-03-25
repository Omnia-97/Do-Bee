import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_new/features/login/pages/login_screen.dart';
import 'package:todo_app_new/firebase/firebase_functions.dart';
import '../../../core/config/app_theme_manager.dart';
import '../../../core/widgets/container_appBar_widget.dart';
import '../../settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsView extends StatelessWidget {
    SettingsView({super.key});
    List<String> languagesList = [
      'English',
      'عربى',
    ];

    List<String> themeList = [
      'Dark',
      'Light',
    ];


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<MyProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;
    var appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerRight,
          children: [
            ContainerAppBarWidget(text: appLocalizations.settings),
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Text('Dear user , \n${provider.userModel!.email } ', style: theme.titleLarge,),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:35,vertical: 30 ),
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
              initialItem: languagesList.first ,
                items: languagesList,
                decoration: CustomDropdownDecoration(
                  closedSuffixIcon: ImageIcon(
                    AssetImage('assets/images/arrow_down.png'),
                    color: AppThemeManager.primaryColor,
                  ),
                  expandedSuffixIcon: ImageIcon(
                    AssetImage('assets/images/arrow_down.png'),
                    color: AppThemeManager.primaryColor,
                  ),
                  closedBorderRadius: BorderRadius.zero,
                  expandedBorderRadius: BorderRadius.zero,
                  closedFillColor: Colors.white,
                  listItemStyle: theme.bodyMedium!.copyWith(color: AppThemeManager.primaryColor),
                  headerStyle: theme.bodyMedium!.copyWith(color: AppThemeManager.primaryColor),
                  closedBorder:Border.all(color: AppThemeManager.primaryColor),

                ),
                onChanged: (value){
                if(value == "English"){
                  provider.changeLanguage('en');
                }else if(value == "عربى"){
                  provider.changeLanguage('ar');
                }
              }

            ),
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
                initialItem: appLocalizations.light,
                  items: [
                    appLocalizations.dark,
                    appLocalizations.light,
                  ],
                  decoration: CustomDropdownDecoration(
                    closedSuffixIcon: ImageIcon(
                      AssetImage('assets/images/arrow_down.png'),
                      color: AppThemeManager.primaryColor,
                    ),
                    expandedSuffixIcon: ImageIcon(
                      AssetImage('assets/images/arrow_down.png'),
                      color: AppThemeManager.primaryColor,
                    ),
                    closedBorderRadius: BorderRadius.zero,
                    expandedBorderRadius: BorderRadius.zero,
                    closedFillColor: Colors.white,
                    listItemStyle: theme.bodyMedium!.copyWith(color: AppThemeManager.primaryColor),
                    headerStyle: theme.bodyMedium!.copyWith(color: AppThemeManager.primaryColor),
                    closedBorder:Border.all(color: AppThemeManager.primaryColor),

                  ),
                  onChanged: (value){
                  if(value == appLocalizations.dark){
                    provider.changeThemeMode(ThemeMode.dark);
                  }else if(value == appLocalizations.light){
                    provider.changeThemeMode(ThemeMode.light);
                  }

                }

              ),
           /* Container(
              padding: const EdgeInsets.all(12),
              width: 319,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppThemeManager.primaryColor,
                ),
              ),
              child: Text(
                appLocalizations.english,
                style: theme.bodyMedium,
              ),
            ),*/

           /* Container(
              padding: const EdgeInsets.all(12),
              width: 319,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppThemeManager.primaryColor,
                ),
              ),
              child: Text(
                appLocalizations.light,
                style: theme.bodyMedium,
              ),
            ),*/
          ],),
        ),



      ],
    );
  }
}


