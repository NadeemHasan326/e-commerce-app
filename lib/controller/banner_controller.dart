import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:e_commerce_app/data/models/banner_model.dart';
import 'package:e_commerce_app/data/repositories/banner_repository.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  /// Variables
  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  RxList<BannerModel> banners = <BannerModel>[].obs;
  final repo = Get.put(BannerRepository());

  /// Update Banner Navigational Dots
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  @override
  void onInit() {
    //repo.uploadDummyBanners(HkDummyData.banners);
    fetchBanners();
    super.onInit();
  }

  /// Fetch Banners
  Future<void> fetchBanners() async {
    try {
      // Start Loading
      isLoading.value = true;

      // fetch banners
      final banners = await repo.fetchBanners();

      // Assign Banners
      this.banners.assignAll(banners);
    } catch (e) {
      // Show Error SnackBar
      HkHelperFunctions.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Stop Loading
      isLoading.value = false;
    }
  }
}
