import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:e_commerce_app/data/models/cart_item_model.dart';
import 'package:e_commerce_app/screens/widgets/brand_title_text_with_verify_icon.dart';
import 'package:e_commerce_app/screens/widgets/product_title.dart';
import 'package:e_commerce_app/screens/widgets/rounded_image.dart';
import 'package:flutter/material.dart';

class HkCartItem extends StatelessWidget {
  const HkCartItem({super.key, required this.cartItem});

  final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    final dark = HkHelperFunctions.isDarkMode(context);

    return Row(
      children: [
        /// Image
        HkRoundedImage(
          imageUrl: cartItem.image ?? '',
          height: 60,
          width: 60,
          isNetworkImage: true,
          padding: const EdgeInsets.all(HkSizes.sm),
          backgroundColor: dark ? HkColors.darkerGrey : HkColors.light,
        ),
        const SizedBox(width: HkSizes.spaceBtwItems),

        /// Title, Price & Size
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HkBrandTitleWithVerifyIcon(title: cartItem.brandName ?? ''),
              HkProductTitleText(title: cartItem.title, maxLines: 1),

              /// Attributes
              Text.rich(
                TextSpan(
                  children: (cartItem.selectedVariation ?? {}).entries
                      .map(
                        (e) => TextSpan(
                          children: [
                            TextSpan(
                              text: ' ${e.key} ',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: '${e.value} ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
