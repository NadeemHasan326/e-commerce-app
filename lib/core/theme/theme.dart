import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/theme/app_themes/app_bar_theme.dart';
import 'package:e_commerce_app/core/theme/app_themes/bottom_sheet_theme.dart';
import 'package:e_commerce_app/core/theme/app_themes/check_box_theme.dart';
import 'package:e_commerce_app/core/theme/app_themes/chip_theme.dart';
import 'package:e_commerce_app/core/theme/app_themes/eleveted_theme.dart';
import 'package:e_commerce_app/core/theme/app_themes/outline_button_theme.dart';
import 'package:e_commerce_app/core/theme/app_themes/text_field.dart';
import 'package:e_commerce_app/core/theme/app_themes/text_theme.dart';
import 'package:flutter/material.dart';

class HkAppTheme {
  HkAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: HkColors.grey,
    brightness: Brightness.light,
    primaryColor: HkColors.primary,
    textTheme: HkTextTheme.lightTextTheme,
    chipTheme: HkChipTheme.lightChipTheme,
    scaffoldBackgroundColor: HkColors.white,
    appBarTheme: HkAppBarTheme.lightAppBarTheme,
    checkboxTheme: HkCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: HkBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: HkElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: HkOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: HkTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: HkColors.grey,
    brightness: Brightness.dark,
    primaryColor: HkColors.primary,
    textTheme: HkTextTheme.darkTextTheme,
    chipTheme: HkChipTheme.darkChipTheme,
    scaffoldBackgroundColor: HkColors.black,
    appBarTheme: HkAppBarTheme.darkAppBarTheme,
    checkboxTheme: HkCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: HkBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: HkElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: HkOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: HkTextFormFieldTheme.darkInputDecorationTheme,
  );
}
