import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  static const Color textColour = Color(0xFFfbfbfe);
  static const backgroundColour = Color(0xFF352C48);
  static const primaryColour = Color(0xFF1E1926);
  static const primaryFgColour = Color(0xFFfbfbfe);
  static const secondaryColour = Color(0xFF6344FC);
  static const secondaryFgColour = Color(0xFFfbfbfe);
  static const accentColour = Color(0xFFB5A2D8);
  static const accentFgColour = Color(0xFFfbfbfe);

  static const fontFamily = GoogleFonts.inter;

  static const double companyTitleSize = 52;
  static const double filmTitleSize = 40;
  static const double filmSubtitleSize = 12;
  static const double bodySize = 20;
  static const double IconSize = 37;
  static const double shapeCornerRadiusSize = 20;

  static const colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primaryColour,
    onPrimary: primaryFgColour,
    secondary: secondaryColour,
    onSecondary: secondaryFgColour,
    tertiary: accentColour,
    onTertiary: accentFgColour,
    surface: backgroundColour,
    onSurface: textColour,
    error: Brightness.dark == Brightness.light ? Color(0xffB3261E) : Color(0xffF2B8B5),
    onError: Brightness.dark == Brightness.light ? Color(0xffFFFFFF) : Color(0xff601410),
);
}