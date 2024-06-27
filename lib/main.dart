import 'dart:ui';
import 'package:DooBee/features/edit_tasks/pages/edit_task.dart';
import 'package:DooBee/features/layout_home/layout_view.dart';
import 'package:DooBee/features/login/pages/login_screen.dart';
import 'package:DooBee/features/onboarding/onboarding_screen.dart';
import 'package:DooBee/features/register/pages/register_screen.dart';
import 'package:DooBee/features/settings_provider.dart';
import 'package:DooBee/features/splash/pages/splash_view.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/config/app_theme_manager.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MyProvider myProvider = MyProvider();
  await myProvider.setItems();
  const fatalError = true;
  // Non-async exceptions
  FlutterError.onError = (errorDetails) {

    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(
    ChangeNotifierProvider<MyProvider>(
        create: (context) => myProvider, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        themeMode: provider.themeMode,
        locale: Locale(provider.languageCode),
        theme: AppThemeManager.lightTheme,
        darkTheme: AppThemeManager.darkTheme,
        initialRoute: provider.firebaseUser != null
            ? LayoutView.routeName
            : SplashView.routeName,
        routes: {
          SplashView.routeName: (context) => const SplashView(),
          OnboardingScreen.routeName: (context) =>  OnboardingScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          LayoutView.routeName: (context) => const LayoutView(),
          EditTask.routeName: (context) => const EditTask(),
        },
      ),
    );
  }
}
