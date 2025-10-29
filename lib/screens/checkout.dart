import 'package:e_commerce_app/controller/cart_controller.dart';
import 'package:e_commerce_app/controller/order_controller.dart';
import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:e_commerce_app/core/utils/pricing_calculator.dart';
import 'package:e_commerce_app/screens/cart_screen.dart';
import 'package:e_commerce_app/screens/widgets/appbar.dart';
import 'package:e_commerce_app/screens/widgets/billing_address_section.dart';
import 'package:e_commerce_app/screens/widgets/billing_amount_section.dart';
import 'package:e_commerce_app/screens/widgets/billing_payment_section.dart';
import 'package:e_commerce_app/screens/widgets/coupon_textfield.dart';
import 'package:e_commerce_app/screens/widgets/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HkHelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    final orderController = Get.put(OrderController());
    final subTotal = cartController.totalCartPrice.value;
    final totalAmount = HkPricingCalculator.calculateTotalPrice(subTotal, 'US');

    return Scaffold(
      appBar: HkAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(HkSizes.defaultSpace),
          child: Column(
            children: [
              const HkCartItems(showAddRemoveButtons: false),
              const SizedBox(height: HkSizes.spaceBtwSections),

              /// Coupon TextField
              const HkCouponCode(),
              const SizedBox(height: HkSizes.spaceBtwSections),

              /// Billing Section
              HkRoundedContainer(
                padding: const EdgeInsets.all(HkSizes.md),
                showBorder: true,
                backgroundColor: dark ? HkColors.black : HkColors.white,
                child: const Column(
                  children: [
                    /// Pricing
                    HkBillingAmountSection(),
                    SizedBox(height: HkSizes.spaceBtwItems),

                    /// Divider
                    Divider(),
                    SizedBox(height: HkSizes.spaceBtwItems),

                    /// payment Methods
                    HkBillingPaymentSection(),
                    SizedBox(height: HkSizes.spaceBtwItems),

                    /// Address
                    HkBillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(HkSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalAmount)
              : () => HkHelperFunctions.errorSnackBar(
                  title: 'Empty Cart',
                  message: 'Add items in the cart in order to proceed',
                ),
          child: Text('Checkout \$$totalAmount'),
        ),
      ),
    );
  }
}
