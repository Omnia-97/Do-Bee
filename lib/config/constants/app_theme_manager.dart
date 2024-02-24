import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeManager {
  static const Color primaryColor = Color(0xFF5D9CEC);
  static const Color darkPrimaryColor = Color(0xFF060E1E);
  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(
          color: Colors.white,
          width: 4,
        ),
      ),
    ),
    scaffoldBackgroundColor: const Color(0xFFDFECDB),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
        size: 38,
      ),
      unselectedIconTheme: IconThemeData(
        color: Color(0xFFC8C9CB),
        size: 30,
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.white,
      elevation: 0,
      padding: EdgeInsets.zero,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: whiteColor,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      displayLarge: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
      bodySmall: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: darkPrimaryColor,
    scaffoldBackgroundColor: darkPrimaryColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(
          color: Color(0xFF141922),
          width: 4,
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
        size: 35,
      ),
      unselectedIconTheme: IconThemeData(
        color: Color(0xFFC8C9CB),
        size: 28,
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color(0xFF141922),
      elevation: 0,
      padding: EdgeInsets.zero,
    ),
  );
}
