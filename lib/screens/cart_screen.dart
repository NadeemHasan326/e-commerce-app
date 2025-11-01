import 'package:e_commerce_app/controller/cart_controller.dart';
import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/constants/image_strings.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/helper/animation_loader.dart';
import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/screens/checkout_screen.dart';
import 'package:e_commerce_app/screens/widgets/appbar.dart';
import 'package:e_commerce_app/screens/widgets/cart_item.dart';
import 'package:e_commerce_app/screens/widgets/circular_icon.dart';
import 'package:e_commerce_app/screens/widgets/product_price_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Scaffold(
      appBar: HkAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Obx(() {
        /// Nothing found widget
        final emptyWidget = HkAnimationLoader(
          text: 'Whoops! Cart is empty',
          animation: HkImages.cartAnimation,
          showAction: true,
          actionText: "Let's fill it",
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(HkSizes.defaultSpace),

              /// Items in Cart
              child: HkCartItems(),
            ),
          );
        }
      }),

      /// Checkout Button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(HkSizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutScreen()),
                child: Obx(
                  () => Text('Checkout \$${controller.totalCartPrice.value}'),
                ),
              ),
            ),
    );
  }
}

class HkCartItems extends StatelessWidget {
  const HkCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) =>
            const SizedBox(height: HkSizes.spaceBtwSections),
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) {
          return Obx(() {
            final cartItem = controller.cartItems[index];
            return Column(
              children: [
                HkCartItem(cartItem: cartItem),
                if (showAddRemoveButtons) ...[
                  const SizedBox(height: HkSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          /// extra Space
                          const SizedBox(width: 70),

                          /// Add & Remove Button
                          HkProductQuantityWithAddRemoveButton(
                            quantity: cartItem.quantity,
                            add: () => controller.addOneToCart(cartItem),
                            remove: () =>
                                controller.removeOneFromCart(cartItem),
                          ),
                        ],
                      ),
                      HkProductPriceText(
                        price: (cartItem.price * cartItem.quantity)
                            .toStringAsFixed(0),
                      ),
                    ],
                  ),
                ],

                /// Add & Remove Buttons
              ],
            );
          });
        },
      ),
    );
  }
}

class HkProductQuantityWithAddRemoveButton extends StatelessWidget {
  const HkProductQuantityWithAddRemoveButton({
    super.key,
    required this.quantity,
    this.add,
    this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    final dark = HkHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        HkCircularIcon(
          icon: Iconsax.minus,
          height: 32,
          width: 32,
          size: HkSizes.md,
          color: dark ? HkColors.white : HkColors.black,
          backgroundColor: dark ? HkColors.darkerGrey : HkColors.light,
          onPressed: remove,
        ),
        const SizedBox(width: HkSizes.spaceBtwItems),
        Text(
          quantity.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(width: HkSizes.spaceBtwItems),
        HkCircularIcon(
          icon: Iconsax.add,
          height: 32,
          width: 32,
          size: HkSizes.md,
          color: HkColors.white,
          backgroundColor: HkColors.primary,
          onPressed: add,
        ),
      ],
    );
  }
}
