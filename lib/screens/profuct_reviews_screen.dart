import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/screens/widgets/appbar.dart';
import 'package:e_commerce_app/screens/widgets/overall_product_rating.dart';
import 'package:e_commerce_app/screens/widgets/product_rating_indicator.dart';
import 'package:e_commerce_app/screens/widgets/user_review_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HkAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(HkSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Rating and reviews are verified and are from people who use the same type of device that you use.",
              ),
              const SizedBox(height: HkSizes.spaceBtwItems),

              ///Overall Product Ratings
              const HkOverallProductRating(),
              const HkRatingBarIndicator(rating: 3.5),
              Text('12,611', style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: HkSizes.spaceBtwSections),

              /// User Review List
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
