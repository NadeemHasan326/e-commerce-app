import 'package:e_commerce_app/controller/signup_controller.dart';
import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/constants/text_strings.dart';
import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HkTermsAndConditionCheckbox extends StatelessWidget {
  const HkTermsAndConditionCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = HkHelperFunctions.isDarkMode(context);

    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value =
                  !controller.privacyPolicy.value,
            ),
          ),
        ),
        const SizedBox(width: HkSizes.spaceBtwItems),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${HkTexts.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: HkTexts.privacyPolicy,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: dark ? HkColors.white : HkColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? HkColors.white : HkColors.primary,
                  ),
                ),
                TextSpan(
                  text: ' ${HkTexts.and} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: HkTexts.termsOfUse,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? HkColors.white : HkColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? HkColors.white : HkColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
