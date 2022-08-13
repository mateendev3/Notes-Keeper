import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_constants.dart';

final ThemeData notesTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.white,
  colorScheme: _getCustomColorScheme(),
  textTheme: _getTextTheme(),
  scaffoldBackgroundColor: AppColors.codGray,
  appBarTheme: _getAppBarTheme(),
);

AppBarTheme _getAppBarTheme() {
  return AppBarTheme(
    elevation: 0.0,
    shadowColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    titleTextStyle: GoogleFonts.poppins(
      color: AppColors.white,
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
    ),
  );
}

TextTheme _getTextTheme() {
  return TextTheme(
    headline1: GoogleFonts.playfairDisplay(
      color: AppColors.codGray,
      fontSize: 40.0,
      fontWeight: FontWeight.w600,
    ),
  );
}

ColorScheme _getCustomColorScheme() {
  return const ColorScheme.dark(
    primary: AppColors.codGray,
    onPrimary: AppColors.white,
    onError: AppColors.red,
    background: AppColors.codGray,
  );
}
