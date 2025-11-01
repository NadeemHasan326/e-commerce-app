import 'package:e_commerce_app/controller/category_controller.dart';
import 'package:e_commerce_app/core/constants/image_strings.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/shimmer/horizontal_product_shimmer.dart';
import 'package:e_commerce_app/core/utils/cloud_helper_functions.dart';
import 'package:e_commerce_app/data/models/category_model.dart';
import 'package:e_commerce_app/screens/all_products_screen.dart';
import 'package:e_commerce_app/screens/widgets/appbar.dart';
import 'package:e_commerce_app/screens/widgets/product_card_horizontal.dart';
import 'package:e_commerce_app/screens/widgets/rounded_image.dart';
import 'package:e_commerce_app/screens/widgets/section_heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: HkAppBar(
        showBackArrow: true,
        title: Text(
          category.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(HkSizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
              const HkRoundedImage(
                imageUrl: HkImages.promoBanner2,
                width: double.infinity,
                applyImageRadius: true,
              ),
              const SizedBox(height: HkSizes.spaceBtwSections),

              /// Sub Categories
              FutureBuilder(
                future: controller.getSubCategories(category.id),
                builder: (context, snapshot) {
                  /// Handle Loader, No Message, Error
                  const loader = HkHorizontalProductShimmer();
                  final widget = HkCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                  );
                  if (widget != null) return widget;

                  /// Record Found
                  final subCategories = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: subCategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final subCategory = subCategories[index];

                      return FutureBuilder(
                        future: controller.getCategoryProducts(
                          categoryId: subCategory.id,
                        ),
                        builder: (context, snapshot) {
                          /// Handle Loader, No Message, Error
                          final widget =
                              HkCloudHelperFunctions.checkMultiRecordState(
                                snapshot: snapshot,
                                loader: loader,
                              );
                          if (widget != null) return widget;

                          /// Record Found
                          final products = snapshot.data!;

                          return Column(
                            children: [
                              /// Heading
                              HkSectionHeading(
                                title: subCategory.name,
                                showActionButton: true,
                                onPressed: () => Get.to(
                                  () => AllProductsScreen(
                                    title: subCategory.name,
                                    futureMethod: controller
                                        .getCategoryProducts(
                                          categoryId: subCategory.id,
                                          limit: -1,
                                        ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: HkSizes.spaceBtwItems / 2),

                              SizedBox(
                                height: 120,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        width: HkSizes.spaceBtwItems,
                                      ),
                                  itemCount: products.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      HkProductCardHorizontal(
                                        product: products[index],
                                      ),
                                ),
                              ),

                              const SizedBox(height: HkSizes.spaceBtwSections),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
