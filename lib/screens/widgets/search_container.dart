import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HkSearchContainer extends StatelessWidget {
  const HkSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = false,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: HkSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    final dark = HkHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: HkHelperFunctions.screenWidth(),
          padding: const EdgeInsets.all(HkSizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                      ? HkColors.dark
                      : HkColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(HkSizes.borderRadiusLg),
            border: showBorder ? Border.all(color: HkColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: HkColors.darkerGrey),
              const SizedBox(width: HkSizes.spaceBtwItems),
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
