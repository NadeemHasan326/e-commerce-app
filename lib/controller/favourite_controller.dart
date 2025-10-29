import 'dart:convert';

import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:e_commerce_app/core/utils/storage_utility.dart';
import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/data/repositories/product_repository.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  static FavouriteController get instance => Get.find();

  /// Variables
  final favourites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  // Method to initialize favourites by reading from storage
  Future<void> initFavourites() async {
    final json = await HkLocalStorage.instance().readData('favourites');
    if (json != null) {
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(
        storedFavourites.map((key, value) => MapEntry(key, value as bool)),
      );
    }
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }

  void toggleFavouriteProduct(String productId) {
    if (!favourites.containsKey(productId)) {
      favourites[productId] = true;
      saveFavouritesToStorage();
      HkHelperFunctions.customToast(
        message: 'Product has been added to the Wishlist',
      );
    } else {
      HkLocalStorage.instance().removeData(productId);
      favourites.remove(productId);
      saveFavouritesToStorage();
      favourites.refresh();
      HkHelperFunctions.customToast(
        message: 'Product has been removed to the Wishlist',
      );
    }
  }

  void saveFavouritesToStorage() {
    final encodedFavourites = jsonEncode(favourites);
    HkLocalStorage.instance().saveData('favourites', encodedFavourites);
  }

  Future<List<ProductModel>> favouriteProducts() async {
    final productIds = favourites.keys.toList();
    return await ProductRepository.instance.getFavouriteProducts(productIds);
  }
}
