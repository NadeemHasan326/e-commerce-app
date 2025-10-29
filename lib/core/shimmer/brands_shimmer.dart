import 'package:e_commerce_app/core/shimmer/grid_layout.dart';
import 'package:e_commerce_app/core/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';

class HkBrandsShimmer extends StatelessWidget {
  const HkBrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return HkGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (context, index) =>
          const HkShimmerEffect(width: 300, height: 80),
    );
  }
}
