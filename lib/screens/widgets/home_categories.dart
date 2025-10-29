import 'package:e_commerce_app/controller/category_controller.dart';
import 'package:e_commerce_app/core/shimmer/category_shimmer.dart';
import 'package:e_commerce_app/screens/widgets/sub_categories.dart';
import 'package:e_commerce_app/screens/widgets/vertical_image_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HkHomeCategories extends StatelessWidget {
  const HkHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Obx(() {
      if (controller.isLoading.value) return const HkCategoryShimmer();

      if (controller.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'No Data Found!',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.apply(color: Colors.white),
          ),
        );
      } else {
        return SizedBox(
          height: 80,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.featuredCategories.length,
            itemBuilder: (context, index) {
              final category = controller.featuredCategories[index];
              return HkVerticalImageText(
                image: category.image,
                title: category.name,
                onTap: () =>
                    Get.to(() => SubCategoriesScreen(category: category)),
              );
            },
          ),
        );
      }
    });
  }
}
