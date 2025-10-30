import 'package:e_commerce_app/controller/user_controller.dart';
import 'package:e_commerce_app/core/constants/image_strings.dart';
import 'package:e_commerce_app/core/helper/full_screen_loader.dart';
import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:e_commerce_app/core/helper/network_manager.dart';
import 'package:e_commerce_app/data/repositories/user_repository.dart';
import 'package:e_commerce_app/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  /// Variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// Init user data when when home screen appears
  @override
  void onInit() {
    super.onInit();
    initializeNames();
  }

  /// Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // Start Loading
      HkFullScreenLoader.openLoadingDialog(
        'We are updating your information...',
        HkImages.docerAnimation,
      );

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        HkFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        HkFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first & last name in the Firebase Firestore
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim(),
      };
      await userRepository.updateSingleField(name);

      // Update the Rx User value
      userController.user.value.firstName = firstName.text;
      userController.user.value.lastName = lastName.text;

      // Remove Loading
      HkFullScreenLoader.stopLoading();

      // Show Success Message
      HkHelperFunctions.successSnackBar(
        title: 'Congratulations',
        message: 'Your name has been updated',
      );

      // Move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      // Stop Loading
      HkFullScreenLoader.stopLoading();
      // Show Error message
      HkHelperFunctions.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
