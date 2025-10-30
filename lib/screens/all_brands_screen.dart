import 'package:e_commerce_app/controller/brand_controller.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/shimmer/brands_shimmer.dart';
import 'package:e_commerce_app/core/shimmer/grid_layout.dart';
import 'package:e_commerce_app/core/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce_app/core/utils/cloud_helper_functions.dart';
import 'package:e_commerce_app/data/models/brand_model.dart';
import 'package:e_commerce_app/screens/widgets/appbar.dart';
import 'package:e_commerce_app/screens/widgets/brand_card.dart';
import 'package:e_commerce_app/screens/widgets/section_heading.dart';
import 'package:e_commerce_app/screens/widgets/sortable_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const HkAppBar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(HkSizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
              const HkSectionHeading(title: 'Brands'),
              const SizedBox(height: HkSizes.spaceBtwItems),

              /// Brands
              Obx(() {
                if (brandController.isLoading.value)
                  return const HkBrandsShimmer();

                if (brandController.allBrands.isEmpty) {
                  return Center(
                    child: Text(
                      'No Data Found!',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.apply(color: Colors.white),
                    ),
                  );
                }

                return HkGridLayout(
                  itemCount: brandController.allBrands.length,
                  mainAxisExtent: 80,
                  itemBuilder: (context, index) {
                    final brand = brandController.allBrands[index];
                    return HkBrandCard(
                      showBorder: false,
                      brand: brand,
                      onTap: () => Get.to(() => BrandProducts(brand: brand)),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: HkAppBar(title: Text(brand.name), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(HkSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Details
              HkBrandCard(brand: brand, showBorder: true),
              const SizedBox(height: HkSizes.spaceBtwSections),

              FutureBuilder(
                future: controller.getBrandProducts(brandId: brand.id),
                builder: (context, snapshot) {
                  // Handle Loader, No Record OR Error Message
                  const loader = HkVerticalProductShimmer();
                  final widget = HkCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                  );
                  if (widget != null) return widget;

                  final products = snapshot.data!;
                  return HkSortableProducts(products: products);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
