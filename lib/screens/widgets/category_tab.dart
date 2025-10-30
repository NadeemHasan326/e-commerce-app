import 'package:e_commerce_app/controller/category_controller.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/shimmer/grid_layout.dart';
import 'package:e_commerce_app/core/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce_app/core/utils/cloud_helper_functions.dart';
import 'package:e_commerce_app/data/models/category_model.dart';
import 'package:e_commerce_app/screens/widgets/all_products.dart';
import 'package:e_commerce_app/screens/widgets/category_brands.dart';
import 'package:e_commerce_app/screens/widgets/product_card_vertical.dart';
import 'package:e_commerce_app/screens/widgets/section_heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HkCategoryTab extends StatelessWidget {
  const HkCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(HkSizes.defaultSpace),
          child: Column(
            children: [
              /// Brands
              CategoryBrands(category: category),
              const SizedBox(height: HkSizes.spaceBtwItems),

              /// Products
              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, snapshot) {
                  /// Handle Error, Loader, Empty Data
                  const loader = HkVerticalProductShimmer();
                  final widget = HkCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                  );
                  if (widget != null) return widget;

                  /// Data Found!
                  final products = snapshot.data!;
                  return Column(
                    children: [
                      HkSectionHeading(
                        title: 'You might like',
                        showActionButton: true,
                        onPressed: () => Get.to(
                          () => AllProducts(
                            title: category.name,
                            futureMethod: controller.getCategoryProducts(
                              categoryId: category.id,
                              limit: -1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: HkSizes.spaceBtwItems),

                      HkGridLayout(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return HkProductCardVertical(product: product);
                        },
                      ),
                      const SizedBox(height: HkSizes.spaceBtwSections),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
