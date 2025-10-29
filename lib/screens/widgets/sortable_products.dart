import 'package:e_commerce_app/controller/all_products_controller.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/shimmer/grid_layout.dart';
import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/screens/widgets/product_card_vertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HkSortableProducts extends StatelessWidget {
  const HkSortableProducts({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            // Sort products based on selected option
            controller.sortProducts(value!);
          },
          items:
              [
                    'Name',
                    'Higher Price',
                    'Lower Price',
                    'Sale',
                    'Newest',
                    'Popularity',
                  ]
                  .map(
                    (option) =>
                        DropdownMenuItem(value: option, child: Text(option)),
                  )
                  .toList(),
        ),
        const SizedBox(height: HkSizes.spaceBtwSections),

        /// Gridview
        Obx(
          () => HkGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (context, index) =>
                HkProductCardVertical(product: controller.products[index]),
          ),
        ),
      ],
    );
  }
}
