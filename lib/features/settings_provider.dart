import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_new/features/settings/pages/settings_view.dart';
import 'package:todo_app_new/features/tasks/pages/tasks_view.dart';
import 'package:todo_app_new/firebase/firebase_functions.dart';
import 'package:todo_app_new/models/user_model.dart';

import '../core/config/app_theme_manager.dart';

class MyProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String languageCode = "en";
  SharedPreferences? sharedPreferences;
  User? firebaseUser;
  UserModel? userModel;

  MyProvider(){
   firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser != null){
      initUser();
    }
  }
  initUser()async{
    userModel = await FirebaseFunctions.readUser();
    notifyListeners();
  }
  Future<void> setItems()async{
    sharedPreferences = await SharedPreferences.getInstance();
    if(getTheme() ?? false){
      themeMode = ThemeMode.dark;
    }else{
      themeMode= ThemeMode.light;
    }
    if(getLang() ?? false){
      languageCode = 'ar';
    }else{
      languageCode = 'en';
    }

  }
  Future<void> saveTheme(bool isDark)async{
    await sharedPreferences!.setBool('isDark', isDark);

  }
  Future<void> saveLang(bool isArabic)async{
    await sharedPreferences!.setBool('isArabic', isArabic);
  }
  bool? getTheme(){
    return sharedPreferences!.getBool('isDark');
  }
  bool? getLang(){
    return sharedPreferences!.getBool('isArabic');
  }
  void changeThemeMode(ThemeMode mode) {
    if(themeMode == mode){
      return;
    }
    themeMode = mode;
    notifyListeners();
  }
  void changeLanguage(String langCode) {

    languageCode = langCode;
    notifyListeners();
  }
  int currentIndex =0;
  List<Widget> tabs = [
    const TasksView(),
      SettingsView(),
  ];



    changeSplashScreen() {
    if (themeMode == ThemeMode.light) {
      return "assets/images/splash_bg.png";
    } else if(themeMode == ThemeMode.dark) {
      return "assets/images/dark_theme/splash_dark_bg.png";
    }

  }
   void changeCurrentIndex (int index){
    currentIndex =index ;
    notifyListeners();
   }
    Color changeCardColor(){
    if(themeMode == ThemeMode.light){
      return AppThemeManager.whiteColor;
    }
    else{
      return AppThemeManager.darkSecondColor;
    }
   }

  Color changeCardTextColor(){
    if(themeMode == ThemeMode.light){
      return AppThemeManager.primaryColor;
    }
    else{
      return AppThemeManager.whiteColor;
    }
  }
   Color changeCardInactiveColor(){
    if(themeMode == ThemeMode.light){
      return AppThemeManager.blackColor;
    }
    else{
      return AppThemeManager.whiteColor;
    }
  }
    changeScaffoldColor(){
    if(themeMode == ThemeMode.light){
      return Colors.transparent;
    }
    else if(themeMode == ThemeMode.dark) {
      return AppThemeManager.darkPrimaryColor;
    }
  }

}
