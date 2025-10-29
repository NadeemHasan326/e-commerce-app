import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:e_commerce_app/data/models/brand_model.dart';
import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/data/repositories/brand_repository.dart';
import 'package:e_commerce_app/data/repositories/product_repository.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  /// Variables
  RxBool isLoading = false.obs;
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final repository = Get.put(BrandRepository());

  @override
  void onInit() {
    //repository.uploadDummyBrands(HkDummyData.brands);
    getFeaturedBrands();
    super.onInit();
  }

  /// Load Brands
  Future<void> getFeaturedBrands() async {
    try {
      // Start Loading
      isLoading.value = true;

      final brands = await repository.getAllBrands();

      allBrands.assignAll(brands);

      featuredBrands.assignAll(
        allBrands.where((brand) => brand.isFeatured ?? false).take(4),
      );
    } catch (e) {
      HkHelperFunctions.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Get Brands for Specific Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await repository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      HkHelperFunctions.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Get Brand specific products from your data source
  Future<List<ProductModel>> getBrandProducts({
    required String brandId,
    int limit = -1,
  }) async {
    try {
      final products = await ProductRepository.instance.getProductsForBrand(
        brandId: brandId,
        limit: limit,
      );
      return products;
    } catch (e) {
      HkHelperFunctions.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}
