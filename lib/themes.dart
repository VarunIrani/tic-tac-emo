import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';

class MyAppThemes {
  static final lightThemeID = 'my_light_theme';
  static final darkThemeID = 'my_dark_theme';

  static final AppTheme lightTheme = AppTheme(
    id: lightThemeID,
    data: ThemeData(
      brightness: Brightness.light,
      textTheme: MyAppThemes.textTheme,
      colorScheme: ColorScheme(
        primary: Color(0xff4f1f93),
        secondary: Color(0xff7c1a40),
        secondaryVariant: Color(0xff5e112f),
        primaryVariant: Color(0xff3d0c87),
        onBackground: Colors.black87,
        onPrimary: Colors.black87,
        onSurface: Color(0xff693aac),
        onError: Colors.white,
        onSecondary: Colors.white,
        background: Color(0xffdcdbfc),
        brightness: Brightness.light,
        surface: Color(0xffac89de),
        error: Color(0xffa12f2f),
      ),
    ),
    description: 'Light Theme for app',
  );
  static final AppTheme darkTheme = AppTheme(
    id: darkThemeID,
    data: ThemeData(
      brightness: Brightness.dark,
      textTheme: MyAppThemes.textTheme,
      colorScheme: ColorScheme(
        primary: Color(0xffac89de),
        secondary: Color(0xffc66088),
        secondaryVariant: Color(0xff870e3e),
        primaryVariant: Color(0xff5b25ab),
        onBackground: Colors.white,
        onPrimary: Colors.white,
        onSurface: Colors.black87,
        onError: Colors.white,
        onSecondary: Colors.white,
        background: Color(0xff1c1b33),
        brightness: Brightness.dark,
        surface: Color(0xffac89de),
        error: Color(0xffa12f2f),
      ),
    ),
    description: 'Dark Theme for app',
  );

  static final TextTheme textTheme = TextTheme(
    headline1: GoogleFonts.poppins(
        fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.poppins(
        fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: GoogleFonts.poppins(fontSize: 46, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.poppins(
        fontSize: 33, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.poppins(
        fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.poppins(
        fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.poppins(
        fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.poppins(
        fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.poppins(
        fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.poppins(
        fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.poppins(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.poppins(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );
}
