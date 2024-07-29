import 'package:draw_and_guess/src/core/theme/colors.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart' show PlatformDispatcher;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ThemeOptions {
  light,
  dark,
  system,
}

abstract class AppTheme {
  static Color get green => const Color(0xFF5AC71C);
  static Brightness brightness = PlatformDispatcher.instance.platformBrightness;

  static ThemeData get lightTheme => FlexThemeData.light(
        colorScheme: flexSchemeLight,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        fontFamily: GoogleFonts.sora().fontFamily,
        textTheme: Config.textTheme,
      );

  static ThemeData get darkTheme => FlexThemeData.dark(
        colorScheme: flexSchemeDark,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 13,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        fontFamily: GoogleFonts.sora().fontFamily,
        textTheme: Config.textTheme,
      );

  static ThemeMode themeMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;

  static ThemeData themeOptions(ThemeOptions option) {
    return switch (option) {
      ThemeOptions.light => lightTheme,
      ThemeOptions.dark => darkTheme,
      ThemeOptions.system => brightness == Brightness.light ? lightTheme : darkTheme,
    };
  }
}
