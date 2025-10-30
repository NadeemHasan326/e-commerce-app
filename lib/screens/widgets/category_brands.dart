import 'package:e_commerce_app/controller/brand_controller.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/shimmer/boxes_shimmer.dart';
import 'package:e_commerce_app/core/shimmer/list_tile_shimmer.dart';
import 'package:e_commerce_app/core/utils/cloud_helper_functions.dart';
import 'package:e_commerce_app/data/models/category_model.dart';
import 'package:e_commerce_app/screens/widgets/brand_show_case.dart';
import 'package:flutter/material.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {
        const loader = Column(
          children: [
            HkListTileShimmer(),
            SizedBox(height: HkSizes.spaceBtwItems),
            HkBoxesShimmer(),
            SizedBox(height: HkSizes.spaceBtwItems),
          ],
        );

        /// Handle Loader, No Record OR No Message
        final widget = HkCloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
          loader: loader,
        );
        if (widget != null) return widget;

        /// Record Found
        final brands = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (context, index) {
            final brand = brands[index];
            return FutureBuilder(
              future: controller.getBrandProducts(brandId: brand.id, limit: 3),
              builder: (context, snapshot) {
                /// Handle Loader, No Record OR No Message
                final widget = HkCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                );
                if (widget != null) return widget;

                /// Record Found
                final products = snapshot.data!;

                return HkBrandShowcase(
                  brand: brand,
                  images: products.map((e) => e.thumbnail).toList(),
                );
              },
            );
          },
        );
      },
    );
  }
}
