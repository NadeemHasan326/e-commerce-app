import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';

class HkBoxesShimmer extends StatelessWidget {
  const HkBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            /// Three Products
            Expanded(child: HkShimmerEffect(width: 150, height: 110)),
            SizedBox(width: HkSizes.spaceBtwItems),
            Expanded(child: HkShimmerEffect(width: 150, height: 110)),
            SizedBox(width: HkSizes.spaceBtwItems),
            Expanded(child: HkShimmerEffect(width: 150, height: 110)),
          ],
        ),
      ],
    );
  }
}
