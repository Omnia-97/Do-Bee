import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeManager {
  static const Color primaryColor = Color(0xFF5D9CEC);
  static const Color darkPrimaryColor = Color(0xFF060E1E);
  static const Color darkSecondColor = Color(0xFF141922);
  static const Color primaryPurpleColor = Color(0xFFAB62FF);
  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(
          color: primaryPurpleColor,
          width: 4,
        ),
      ),
    ),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      selectedIconTheme: const IconThemeData(
        color: primaryPurpleColor,
        size: 30,
      ),
      unselectedIconTheme: IconThemeData(
        color: blackColor.withOpacity(0.2),
        size: 28,
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
      displayMedium: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    iconTheme: const IconThemeData(
      color: whiteColor,
    ),
    scaffoldBackgroundColor: darkPrimaryColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(
          color: darkSecondColor,
          width: 4,
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedIconTheme: const IconThemeData(
        color: primaryPurpleColor,
        size: 30,
      ),
      unselectedIconTheme: IconThemeData(
        color: blackColor.withOpacity(0.2),
        size: 28,
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: darkSecondColor,
      elevation: 0,
      padding: EdgeInsets.zero,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: darkPrimaryColor,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      displayLarge: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodySmall: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      displayMedium: GoogleFonts.roboto(
          fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
    ),
  );
}
