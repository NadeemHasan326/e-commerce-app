import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/controller/all_products_controller.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce_app/core/utils/cloud_helper_functions.dart';
import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/screens/widgets/appbar.dart';
import 'package:e_commerce_app/screens/widgets/sortable_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({
    super.key,
    required this.title,
    this.query,
    this.futureMethod,
  });

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());

    return Scaffold(
      appBar: HkAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(HkSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (context, snapshot) {
              // Check the state of FutureBuilder snapshot
              const loader = HkVerticalProductShimmer();
              final widget = HkCloudHelperFunctions.checkMultiRecordState(
                snapshot: snapshot,
                loader: loader,
              );

              // Return appropriate widget based on snapshot state
              if (widget != null) return widget;

              // Products Found
              final products = snapshot.data!;

              return HkSortableProducts(products: products);
            },
          ),
        ),
      ),
    );
  }
}
