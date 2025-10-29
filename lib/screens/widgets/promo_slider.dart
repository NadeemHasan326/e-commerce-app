import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/controller/banner_controller.dart';
import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/shimmer/shimmer_effect.dart';
import 'package:e_commerce_app/screens/widgets/circular_container.dart';
import 'package:e_commerce_app/screens/widgets/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HkPromoSlider extends StatelessWidget {
  const HkPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(() {
      if (controller.isLoading.value)
        return const HkShimmerEffect(width: double.infinity, height: 190);

      if (controller.banners.isEmpty) {
        return const Center(child: Text('No Data Found!'));
      } else {
        return Column(
          children: [
            CarouselSlider(
              items: controller.banners
                  .map(
                    (banner) => HkRoundedImage(
                      imageUrl: banner.imageUrl,
                      isNetworkImage: true,
                      onPressed: () => Get.toNamed(banner.targetScreen),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, reason) =>
                    controller.updatePageIndicator(index),
              ),
            ),
            const SizedBox(height: HkSizes.spaceBtwItems),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < controller.banners.length; i++)
                    HkCircularContainer(
                      width: 20,
                      height: 4,
                      margin: const EdgeInsets.only(right: 10),
                      backgroundColor:
                          (controller.carouselCurrentIndex.value == i)
                          ? HkColors.primary
                          : HkColors.grey,
                    ),
                ],
              ),
            ),
          ],
        );
      }
    });
  }
}
