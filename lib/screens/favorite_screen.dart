import 'package:e_commerce_app/controller/favourite_controller.dart';
import 'package:e_commerce_app/core/constants/image_strings.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/helper/animation_loader.dart';
import 'package:e_commerce_app/core/shimmer/grid_layout.dart';
import 'package:e_commerce_app/core/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce_app/core/utils/cloud_helper_functions.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/screens/home_screen.dart';
import 'package:e_commerce_app/screens/widgets/appbar.dart';
import 'package:e_commerce_app/screens/widgets/circular_icon.dart';
import 'package:e_commerce_app/screens/widgets/product_card_vertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouriteController.instance;
    return Scaffold(
      appBar: HkAppBar(
        title: Text(
          'WishList',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          HkCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(() => const HomeScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(HkSizes.defaultSpace),

          /// Product Grid
          child: Obx(
            () => FutureBuilder(
              future: controller.favouriteProducts(),
              builder: (context, snapshot) {
                /// Nothing found widget
                final emptyWidget = HkAnimationLoader(
                  text: 'Whoops! Wishlist is Empty...',
                  animation: HkImages.pencilAnimation,
                  showAction: true,
                  actionText: "Let's add some",
                  onActionPressed: () => Get.off(() => const NavigationMenu()),
                );

                /// Loading Widget
                const loader = HkVerticalProductShimmer(itemCount: 6);

                final widget = HkCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                  nothingFound: emptyWidget,
                );
                if (widget != null) return widget;

                final products = snapshot.data!;
                return HkGridLayout(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return HkProductCardVertical(product: products[index]);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
