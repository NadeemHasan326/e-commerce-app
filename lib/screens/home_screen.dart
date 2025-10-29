import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/controller/product_controller.dart';
import 'package:e_commerce_app/controller/user_controller.dart';
import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/constants/text_strings.dart';
import 'package:e_commerce_app/core/shimmer/grid_layout.dart';
import 'package:e_commerce_app/core/shimmer/shimmer_effect.dart';
import 'package:e_commerce_app/core/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce_app/screens/widgets/all_products.dart';
import 'package:e_commerce_app/screens/widgets/appbar.dart';
import 'package:e_commerce_app/screens/widgets/cart_menu_icon.dart';
import 'package:e_commerce_app/screens/widgets/home_categories.dart';
import 'package:e_commerce_app/screens/widgets/primary_header_container.dart';
import 'package:e_commerce_app/screens/widgets/product_card_vertical.dart';
import 'package:e_commerce_app/screens/widgets/promo_slider.dart';
import 'package:e_commerce_app/screens/widgets/search_container.dart';
import 'package:e_commerce_app/screens/widgets/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HkPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// Appbar
                  HkHomeAppBar(),
                  SizedBox(height: HkSizes.spaceBtwSections),

                  /// SearchBar
                  HkSearchContainer(text: 'Search in Store'),
                  SizedBox(height: HkSizes.spaceBtwSections),

                  /// Categories
                  Padding(
                    padding: EdgeInsets.only(left: HkSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// Heading
                        HkSectionHeading(
                          title: 'Popular Categories',
                          textColor: HkColors.white,
                        ),
                        SizedBox(height: HkSizes.spaceBtwItems),

                        /// Categories
                        HkHomeCategories(),
                      ],
                    ),
                  ),
                  SizedBox(height: HkSizes.spaceBtwItems * 1.5),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(HkSizes.defaultSpace),
              child: Column(
                children: [
                  /// Promo Slider
                  const HkPromoSlider(),
                  const SizedBox(height: HkSizes.spaceBtwSections),

                  /// Heading
                  HkSectionHeading(
                    title: 'Popular Products',
                    showActionButton: true,
                    onPressed: () => Get.to(
                      () => AllProducts(
                        title: 'Popular Products',
                        //query: FirebaseFirestore.instance.collection("Products").where("IsFeatured",isEqualTo: true).limit(6),
                        futureMethod: controller.fetchAllFeaturedProducts(),
                      ),
                    ),
                  ),
                  const SizedBox(height: HkSizes.spaceBtwItems),

                  /// Popular Products
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const HkVerticalProductShimmer();
                    }

                    if (controller.featuredProducts.isEmpty) {
                      return Center(
                        child: Text(
                          'No Data Found!',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    } else {
                      return HkGridLayout(
                        itemCount: controller.featuredProducts.length,
                        itemBuilder: (context, index) => HkProductCardVertical(
                          product: controller.featuredProducts[index],
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HkHomeAppBar extends StatelessWidget {
  const HkHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return HkAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            HkTexts.homeAppbarTitle,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: HkColors.grey),
          ),
          Obx(() {
            if (controller.profileLoading.value) {
              // Display a shimmer loader while user profile is being loaded
              return const HkShimmerEffect(width: 80, height: 15);
            } else {
              return Text(
                controller.user.value.fullName,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.apply(color: HkColors.white),
              );
            }
          }),
        ],
      ),
      actions: const [HkCartCounterIcon(iconColor: HkColors.white)],
    );
  }
}
