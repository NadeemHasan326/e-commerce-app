import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:flutter/material.dart';

class HkChipTheme {
  HkChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: HkColors.grey.withValues(alpha: 0.4),
    labelStyle: const TextStyle(color: HkColors.black),
    selectedColor: HkColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: HkColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: HkColors.darkerGrey,
    labelStyle: TextStyle(color: HkColors.white),
    selectedColor: HkColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: HkColors.white,
  );
}
