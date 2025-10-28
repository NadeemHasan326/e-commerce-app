import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:flutter/cupertino.dart';

class HkShadowStyle {
  static final verticalProductShadow = BoxShadow(
    color: HkColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );

  static final horizontalProductShadow = BoxShadow(
    color: HkColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}
