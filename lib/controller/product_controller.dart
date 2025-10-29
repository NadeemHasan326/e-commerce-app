import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/data/repositories/product_repository.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    fetchFeaturedProducts();
    // Upload all Products
    //productRepository.uploadDummyProducts(HkDummyData.products);
    // Upload Categories
    //CategoryRepository().uploadDummyData(HkDummyData.categories);
    // // upload Banners
    //BannerRepository().uploadDummyBanners(HkDummyData.banners);
    // // Upload Brands
    //BrandRepository().uploadDummyBrands(HkDummyData.brands);
    // Upload Product Category
    //CategoryRepository().uploadDummyProductCategory(HkDummyData.productCategory);
    // Upload Brand Category
    //CategoryRepository().uploadDummyBrandCategory(HkDummyData.brandCategory);

    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      // show loading
      isLoading.value = true;

      // Fetch Products
      final products = await productRepository.getFeaturedProducts();

      // Assign Products
      featuredProducts.assignAll(products);
    } catch (e) {
      HkHelperFunctions.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Stop loading
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      // Fetch Products
      final products = await productRepository.getAllFeaturedProducts();
      return products;
    } catch (e) {
      HkHelperFunctions.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// get the product price or price range for variations
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // If no variation exist, return the simple price or sale price
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0.0 ? product.salePrice : product.price)
          .toString();
    } else {
      // Calculate smallest and largest  price among variations
      for (var variation in product.productVariations!) {
        // Determine the price to consider (sale price if available, otherwise regular price)
        double priceToConsider = variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price;

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
      }
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toStringAsFixed(0);
      } else {
        return '${largestPrice.toStringAsFixed(0)} - \$${smallestPrice.toStringAsFixed(0)}';
      }
    }
  }

  /// Calculate Discount Percent
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0.0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(1); // not give decimal answer
  }

  /// Check Product Stock
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
