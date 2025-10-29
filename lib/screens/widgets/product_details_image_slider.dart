import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/controller/images_controller.dart';
import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/screens/widgets/appbar.dart';
import 'package:e_commerce_app/screens/widgets/curved_edges_widget.dart';
import 'package:e_commerce_app/screens/widgets/favourite_icon.dart';
import 'package:e_commerce_app/screens/widgets/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HkProductImageSlider extends StatelessWidget {
  const HkProductImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);

    final dark = HkHelperFunctions.isDarkMode(context);
    return HkCurvedEdgesWidget(
      child: Container(
        color: dark ? HkColors.darkerGrey : HkColors.light,
        child: Stack(
          children: [
            /// Main Large Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(HkSizes.productImageRadius * 2),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargeImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (context, url, progress) =>
                            CircularProgressIndicator(
                              color: HkColors.primary,
                              value: progress.progress,
                            ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            /// Image Slider
            Positioned(
              right: 0,
              left: HkSizes.defaultSpace,
              bottom: 30,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: HkSizes.spaceBtwItems),
                  itemCount: images.length,
                  itemBuilder: (context, index) => Obx(() {
                    final imageSelected =
                        controller.selectedProductImage.value == images[index];
                    return HkRoundedImage(
                      width: 80,
                      isNetworkImage: true,
                      onPressed: () =>
                          controller.selectedProductImage.value = images[index],
                      backgroundColor: dark ? HkColors.dark : HkColors.white,
                      border: Border.all(
                        color: imageSelected
                            ? HkColors.primary
                            : Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(HkSizes.sm),
                      imageUrl: images[index],
                    );
                  }),
                ),
              ),
            ),

            /// AppBar Icons
            HkAppBar(
              showBackArrow: true,
              actions: [HkFavouriteIcon(productId: product.id)],
            ),
          ],
        ),
      ),
    );
  }
}
