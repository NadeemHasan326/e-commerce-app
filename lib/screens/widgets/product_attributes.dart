import 'package:e_commerce_app/controller/variation_controller.dart';
import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/screens/widgets/choice_chip.dart';
import 'package:e_commerce_app/screens/widgets/product_price_text.dart';
import 'package:e_commerce_app/screens/widgets/product_title.dart';
import 'package:e_commerce_app/screens/widgets/rounded_container.dart';
import 'package:e_commerce_app/screens/widgets/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HkProductAttributes extends StatelessWidget {
  const HkProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = HkHelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
      () => Column(
        children: [
          /// Selected Attribute Pricing & Description
          // Display variation price and stock when some variation is selected
          if (controller.selectedVariation.value.id.isNotEmpty)
            HkRoundedContainer(
              backgroundColor: dark ? HkColors.darkerGrey : HkColors.grey,
              padding: const EdgeInsets.all(HkSizes.md),

              /// Title, Price and Stock Status
              child: Column(
                children: [
                  Row(
                    children: [
                      const HkSectionHeading(title: 'Variation'),
                      const SizedBox(width: HkSizes.spaceBtwItems),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Price Row
                          Row(
                            children: [
                              const HkProductTitleText(
                                title: 'Price : ',
                                smallSize: true,
                              ),

                              /// Actual Price
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                Text(
                                  '\$${controller.selectedVariation.value.price.toStringAsFixed(0)}',
                                  style: Theme.of(context).textTheme.titleSmall!
                                      .apply(
                                        overflow: TextOverflow.ellipsis,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                              const SizedBox(width: HkSizes.spaceBtwItems),

                              /// Sale Price
                              HkProductPriceText(
                                price: controller.getVariationPrice(),
                              ),
                            ],
                          ),

                          /// Stock Row
                          Row(
                            children: [
                              const HkProductTitleText(
                                title: 'Stock : ',
                                smallSize: true,
                              ),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  /// Variation Description
                  HkProductTitleText(
                    title: controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          const SizedBox(height: HkSizes.spaceBtwItems),

          /// Attributes
          /// Multiple Colors Attributes & Multiple Sizes Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!.map((attribute) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HkSectionHeading(title: attribute.name ?? ''),
                  const SizedBox(height: HkSizes.spaceBtwItems / 2),
                  Obx(
                    () => Wrap(
                      spacing: 8,
                      children: attribute.values!.map((attributeValue) {
                        final isSelected =
                            controller.selectedAttributes[attribute.name] ==
                            attributeValue; // 'Green' == 'Green'
                        final available = controller
                            .getAttributesAvailabilityInVariation(
                              product.productVariations!,
                              attribute.name!,
                            )
                            .contains(attributeValue);
                        return HkChoiceChip(
                          text: attributeValue,
                          selected: isSelected,
                          onSelected: available
                              ? (selected) {
                                  if (available && selected) {
                                    controller.onAttributeSelected(
                                      product,
                                      attribute.name ?? '',
                                      attributeValue,
                                    );
                                  }
                                }
                              : null,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
