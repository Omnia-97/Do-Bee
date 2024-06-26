import 'dart:async';
import 'package:DooBee/features/onboarding/onboarding_screen.dart';
import 'package:DooBee/features/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../login/pages/login_screen.dart';

class SplashView extends StatefulWidget {
  static const String routeName = 'Splash Screen';
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(
        context,
        OnboardingScreen.routeName,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Image(
        image: AssetImage(
          provider.changeSplashScreen(),
        ),
        fit: BoxFit.fill,
        height: mediaQuery.height,
        width: mediaQuery.width,
      ),
    );
  }
}
