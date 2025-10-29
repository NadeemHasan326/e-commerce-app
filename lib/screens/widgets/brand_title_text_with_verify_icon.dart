import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/screens/widgets/brand_title.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HkBrandTitleWithVerifyIcon extends StatelessWidget {
  const HkBrandTitleWithVerifyIcon({
    super.key,
    this.textColor,
    this.maxLines = 1,
    required this.title,
    this.iconColor = HkColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: HkBrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
          ),
        ),
        const SizedBox(width: HkSizes.xs),
        Icon(Iconsax.verify5, color: iconColor, size: HkSizes.iconXs),
      ],
    );
  }
}
