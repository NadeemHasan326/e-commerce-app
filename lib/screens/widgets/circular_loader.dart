import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:flutter/material.dart';

class HkCircularLoader extends StatelessWidget {
  const HkCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(HkSizes.lg),
      decoration: const BoxDecoration(
        color: HkColors.primary,
        shape: BoxShape.circle,
      ),
      child: const CircularProgressIndicator(color: HkColors.white),
    );
  }
}
