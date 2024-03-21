import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_new/features/settings/pages/settings_view.dart';
import 'package:todo_app_new/features/tasks/pages/tasks_view.dart';
import 'package:todo_app_new/firebase/firebase_functions.dart';
import 'package:todo_app_new/models/user_model.dart';

import '../core/config/app_theme_manager.dart';

class MyProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String languageCode = "en";
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



  String changeSplashScreen() {
    if (themeMode == ThemeMode.light) {
      return "assets/images/splash_bg.png";
    } else {
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

}
