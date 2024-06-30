import 'package:flutter/material.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

/// App Theme
class AppTheme extends GetXState {
  static ThemeData mainTheme() {
    return FlexThemeData.light(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff37B7C3),
        onPrimary: Color(0xffF5F5F5),
        primaryContainer: Color(0xffdce1ff),
        onPrimaryContainer: Color(0xff0d0d0e),
        secondary: Color(0xff135D66),
        onSecondary: Color(0xffF5F5F5),
        secondaryContainer: Color(0xffdee1f9),
        onSecondaryContainer: Color(0xff0d0d0e),
        tertiary: Color(0xff5c5b7e),
        onTertiary: Color(0xffF5F5F5),
        tertiaryContainer: Color(0xffc8dbf8),
        onTertiaryContainer: Color(0xff0c0d0e),
        error: Color(0xffba1a1a),
        onError: Color(0xffF5F5F5),
        errorContainer: Color(0xffffdad6),
        onErrorContainer: Color(0xff410002),
        surface: Color(0xffF3F3F3),
        onSurface: Color(0xff090909),
        onSurfaceVariant: Color(0xff0d0d0d),
        outline: Color(0xff7c7c7c),
        outlineVariant: Color(0xffc8c8c8),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xff343434),
        onInverseSurface: Color(0xffffffff),
        inversePrimary: Color(0xff99c4ff),
        surfaceTint: Color(0xfff6f6f6),
      ),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      subThemesData: const FlexSubThemesData(
        alignedDropdown: true,
        chipRadius: 16,
        defaultRadius: 16,
        fabAlwaysCircular: true,
        fabUseShape: true,
        useInputDecoratorThemeInDialogs: true,
        useTextTheme: true,
      ),
      useMaterial3ErrorColors: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      swapLegacyOnMaterial3: true,
      typography: Typography.material2021(),
      fontFamily: GoogleFonts.inter().fontFamily,
    );
  }
}
