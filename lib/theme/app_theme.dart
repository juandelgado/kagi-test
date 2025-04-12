import 'package:flutter/material.dart';

// more info:
// https://api.flutter.dev/flutter/material/ThemeData-class.html
// https://api.flutter.dev/flutter/material/ColorScheme/ColorScheme.dark.html#material.ColorScheme.dark.1

class AppThemes {
  static const seedColor = Color(0xffbb86fc);

  static final darkColorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark,
    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
  );

  static final lightColorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: darkColorScheme.primary,
    colorScheme: darkColorScheme,
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(),
        ),
      ),
    ),
    progressIndicatorTheme:
        ProgressIndicatorThemeData(color: darkColorScheme.inversePrimary),
    useMaterial3: true,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: lightColorScheme.primary,
    colorScheme: lightColorScheme,
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(),
        ),
      ),
    ),
    progressIndicatorTheme:
        ProgressIndicatorThemeData(color: lightColorScheme.inversePrimary),
    useMaterial3: true,
  );
}
