import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_new/features/layout_home/layout_view.dart';
import 'package:todo_app_new/features/settings_provider.dart';

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
        LayoutView.routeName,
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
