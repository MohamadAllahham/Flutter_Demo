import 'package:flutter/material.dart';

const defaultPadding = 16.0;
const scrollableSpace = 16.0;
const defaultEmojiHeight = 24.0;

// colors are private on purpose, access them from Theme.of(context).colorScheme
const _primaryColor = Color(0xff338585);
const _accentColor = Color(0xfffac72c);
const _errorColor = Color(0xfff44336);
const _white = Color(0xffffffff);
const _darkColor = Color(0xff828282);
const _darkestColor = Color(0xff222222);

final themeData = ThemeData.from(
  textTheme: ThemeData(
    fontFamily: 'VarelaRound',
  ).textTheme,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: _primaryColor,
    onPrimary: _white,
    secondary: _accentColor,
    onSecondary: _darkestColor,
    error: _errorColor,
    onError: _white,
    surface: _white,
    onSurface: _darkestColor,
  ),
).copyWith(
  visualDensity: VisualDensity.standard,
  appBarTheme: const AppBarTheme(
    backgroundColor: _primaryColor,
    iconTheme: IconThemeData(color: _darkColor),
    foregroundColor: _white,
  ),
  iconTheme: const IconThemeData(color: _darkColor),
  tabBarTheme: const TabBarTheme(
    labelColor: _white,
    unselectedLabelColor: _primaryColor,
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: BoxDecoration(
      color: _primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _primaryColor,
      foregroundColor: _white,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    iconColor: _darkColor,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _darkColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _primaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _errorColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _errorColor),
    ),
    floatingLabelStyle: TextStyle(color: _primaryColor),
    labelStyle: TextStyle(color: _darkColor),
    alignLabelWithHint: true,
  ),
  listTileTheme: const ListTileThemeData(iconColor: _darkColor),
  dividerTheme: const DividerThemeData(color: _darkColor),
  checkboxTheme: const CheckboxThemeData(
    side: BorderSide(
      color: _darkColor,
    ),
  ),
);

Color lighten(Color color, [double percent = 0.1]) {
  assert(percent >= 0 && percent <= 1);
  return _withLightnessDelta(color, percent);
}

Color darken(Color color, [double percent = 0.1]) {
  assert(percent >= 0 && percent <= 1);
  return _withLightnessDelta(color, -percent);
}

Color _withLightnessDelta(Color color, double deltaPercent) {
  final hsl = HSLColor.fromColor(color);
  final hslLighter =
      hsl.withLightness((hsl.lightness + deltaPercent).clamp(0.0, 1.0));

  return hslLighter.toColor();
}
