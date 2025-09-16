// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:google_fonts/google_fonts.dart';

// 🌎 Project imports:
import 'package:modulohu_web/src/themes/color_schemes.g.dart';

class Themes {
  static final lightThemeData = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: ColorSchemes.lightColorScheme,
    useMaterial3: false,
  );

  static final darkThemeData = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: ColorSchemes.darkColorScheme,
    useMaterial3: false,
  );

  static const loadingBarColor = Colors.green;
}
