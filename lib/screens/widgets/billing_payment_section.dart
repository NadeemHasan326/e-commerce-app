import 'package:e_commerce_app/controller/checkout_controller.dart';
import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:e_commerce_app/screens/widgets/rounded_container.dart';
import 'package:e_commerce_app/screens/widgets/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HkBillingPaymentSection extends StatelessWidget {
  const HkBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    final dark = HkHelperFunctions.isDarkMode(context);

    return Column(
      children: [
        HkSectionHeading(
          title: 'Payment Method',
          showActionButton: true,
          onPressed: () => controller.selectPaymentMethod(context),
          buttonTitle: 'Change',
        ),
        const SizedBox(height: HkSizes.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              HkRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? HkColors.light : HkColors.white,
                padding: const EdgeInsets.all(HkSizes.sm),
                child: Image(
                  image: AssetImage(
                    controller.selectedPaymentMethod.value.image,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: HkSizes.spaceBtwItems / 2),
              Text(
                controller.selectedPaymentMethod.value.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
