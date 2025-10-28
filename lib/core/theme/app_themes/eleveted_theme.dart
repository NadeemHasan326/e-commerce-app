import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:flutter/material.dart';

class HkElevatedButtonTheme {
  HkElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: HkColors.light,
      backgroundColor: HkColors.primary,
      disabledForegroundColor: HkColors.darkGrey,
      disabledBackgroundColor: HkColors.buttonDisabled,
      side: const BorderSide(color: HkColors.lightContainer),
      padding: const EdgeInsets.symmetric(vertical: HkSizes.buttonHeight),
      textStyle: const TextStyle(
        fontSize: 16,
        color: HkColors.textWhite,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(HkSizes.buttonRadius),
      ),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: HkColors.light,
      backgroundColor: HkColors.primary,
      disabledForegroundColor: HkColors.darkGrey,
      disabledBackgroundColor: HkColors.darkerGrey,
      side: const BorderSide(color: HkColors.primary),
      padding: const EdgeInsets.symmetric(vertical: HkSizes.buttonHeight),
      textStyle: const TextStyle(
        fontSize: 16,
        color: HkColors.textWhite,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(HkSizes.buttonRadius),
      ),
    ),
  );
}
