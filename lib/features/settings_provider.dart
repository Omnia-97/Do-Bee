import 'package:DooBee/features/settings/pages/settings_view.dart';
import 'package:DooBee/firebase/firebase_functions.dart';
import 'package:DooBee/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/config/app_theme_manager.dart';
import 'tasks/pages/tasks_view.dart';

class MyProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String languageCode = "en";
  SharedPreferences? sharedPreferences;
  User? firebaseUser;
  UserModel? userModel;

  MyProvider() {
    initializeUser();
  }
  Future<void> initializeUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await initUser();
    }
  }

  Future<void> initUser() async {
    userModel = await FirebaseFunctions.readUser();
    notifyListeners();
  }

  Future<void> setItems() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences != null) {
      if (getTheme() ?? false) {
        themeMode = ThemeMode.dark;
      } else {
        themeMode = ThemeMode.light;
      }
      if (getLang() ?? false) {
        languageCode = 'ar';
      } else {
        languageCode = 'en';
      }
    }
  }

  Future<void> saveTheme(bool isDark) async {
    if (sharedPreferences != null) {
      await sharedPreferences!.setBool('isDark', isDark);
    }
  }

  Future<void> saveLang(bool isArabic) async {
    if (sharedPreferences != null) {
      await sharedPreferences!.setBool('isArabic', isArabic);
    }
  }

  bool? getTheme() {
    if (sharedPreferences != null) {
      return sharedPreferences!.getBool('isDark');
    }
    return null;
  }

  bool? getLang() {
    if (sharedPreferences != null) {
      return sharedPreferences!.getBool('isArabic');
    }
    return null;
  }

  void changeThemeMode(ThemeMode mode) {
    if (mode == themeMode) {
      return;
    }
    themeMode = mode;
    if (themeMode == ThemeMode.dark) {
      saveTheme(true);
    } else {
      saveTheme(false);
    }
    notifyListeners();
  }

  void changeLanguage(String langCode) {
    if (langCode == languageCode) {
      return;
    }
    languageCode = langCode;
    if (languageCode == 'ar') {
      saveLang(true);
    } else {
      saveLang(false);
    }
    notifyListeners();
  }

  int currentIndex = 0;
  List<Widget> tabs = [
    const TasksView(),
    const SettingsView(),
  ];

  changeSplashScreen() {
    if (themeMode == ThemeMode.light) {
      return "assets/images/splash_bg.png";
    } else if (themeMode == ThemeMode.dark) {
      return "assets/images/dark_theme/splash_dark_bg.png";
    }
  }

  void changeCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Color changeCardColor() {
    if (themeMode == ThemeMode.light) {
      return AppThemeManager.whiteColor;
    } else {
      return AppThemeManager.darkSecondColor;
    }
  }

  Color changeCardTextColor() {
    if (themeMode == ThemeMode.light) {
      return AppThemeManager.primaryColor;
    } else {
      return AppThemeManager.whiteColor;
    }
  }

  Color changeCardInactiveColor() {
    if (themeMode == ThemeMode.light) {
      return AppThemeManager.blackColor;
    } else {
      return AppThemeManager.whiteColor;
    }
  }

  changeScaffoldColor() {
    if (themeMode == ThemeMode.light) {
      return Colors.transparent;
    } else if (themeMode == ThemeMode.dark) {
      return AppThemeManager.darkPrimaryColor;
    }
  }

  Color changeLogoutColor() {
    if (themeMode == ThemeMode.light) {
      return AppThemeManager.whiteColor;
    } else {
      return AppThemeManager.darkPrimaryColor;
    }
  }

  Color changeEditText() {
    if (themeMode == ThemeMode.light) {
      return const Color(
        0xFF383838,
      );
    } else {
      return AppThemeManager.whiteColor;
    }
  }

  Color changeLoginScaffoldColor() {
    if (themeMode == ThemeMode.light) {
      return AppThemeManager.whiteColor;
    } else {
      return AppThemeManager.blackColor;
    }
  }
}
