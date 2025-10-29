import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class HkCircularIcon extends StatelessWidget {
  const HkCircularIcon({
    super.key,
    required this.icon,
    this.size = HkSizes.lg,
    this.backgroundColor,
    this.onPressed,
    this.height,
    this.width,
    this.color,
  });

  final double? width, height, size;
  final IconData? icon;
  final Color? color, backgroundColor;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final dark = HkHelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: (backgroundColor != null)
            ? backgroundColor
            : dark
            ? HkColors.dark.withOpacity(0.9)
            : HkColors.light.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: size),
      ),
    );
  }
}
