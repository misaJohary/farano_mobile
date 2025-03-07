import 'package:flutter/material.dart';

const _borderField = OutlineInputBorder(
  borderSide:
  BorderSide(color: Color(0xFFFDA718), width: 5),
  borderRadius: BorderRadius.all(
    Radius.circular(20),
  ),
);

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFDA819)),
  useMaterial3: true,
  fontFamily: 'CarterOne',
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFA87538),
    border: _borderField,
    enabledBorder: _borderField,
    focusedBorder: _borderField,
    hintStyle: TextStyle(color: Colors.white, ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFDA718),
      shadowColor: Colors.transparent,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.white, width: 2),
      ),
    ),
  ),
);
