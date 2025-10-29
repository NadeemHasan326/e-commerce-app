import 'package:e_commerce_app/core/constants/image_strings.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/helper/full_screen_loader.dart';
import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:e_commerce_app/core/helper/network_manager.dart';
import 'package:e_commerce_app/core/utils/cloud_helper_functions.dart';
import 'package:e_commerce_app/data/models/address_model.dart';
import 'package:e_commerce_app/data/repositories/address_repository.dart';
import 'package:e_commerce_app/screens/widgets/circular_loader.dart';
import 'package:e_commerce_app/screens/widgets/section_heading.dart';
import 'package:e_commerce_app/screens/widgets/single_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  /// Fetch all user specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
        (address) => address.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      return addresses;
    } catch (e) {
      HkHelperFunctions.errorSnackBar(
        title: 'Address not found',
        message: e.toString(),
      );
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async {
          return false;
        },
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const HkCircularLoader(),
      );

      // Clear the "selected" field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
          selectedAddress.value.id,
          false,
        );
      }
      // Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Set the "selected" field to true for the newly selected Address
      await addressRepository.updateSelectedField(
        selectedAddress.value.id,
        true,
      );

      Get.back();
    } catch (e) {
      Get.back();
      HkHelperFunctions.errorSnackBar(
        title: 'Error in Selection',
        message: e.toString(),
      );
    }
  }

  /// Add New Address Method
  Future addNewAddress() async {
    try {
      // Start Loading
      HkFullScreenLoader.openLoadingDialog(
        'Storing Address...',
        HkImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        HkFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        HkFullScreenLoader.stopLoading();
        return;
      }

      // Save Address Data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        dateTime: DateTime.now(),
        selectedAddress: true,
      );
      final id = await addressRepository.addAddress(address);

      // Update Selected Address status
      address.id = id;
      selectAddress(address);

      // Remove Loader
      HkFullScreenLoader.stopLoading();

      // show Success message
      HkHelperFunctions.successSnackBar(
        title: 'Congratulations',
        message: 'Your address has been saved successfully',
      );

      // Refresh Addresses Data
      refreshData.toggle();

      // Reset fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
      Navigator.of(Get.context!).pop();
    } catch (e) {
      HkFullScreenLoader.stopLoading();
      HkHelperFunctions.errorSnackBar(
        title: 'Address not found',
        message: e.toString(),
      );
    }
  }

  /// Show Addresses  ModalBottomSheet at checkout
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(HkSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HkSectionHeading(title: 'Select Address'),
            FutureBuilder(
              future: getAllUserAddresses(),
              builder: (context, snapshot) {
                /// helper Function to handle error, empty and loader
                final widget = HkCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                );
                if (widget != null) return widget;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => HkSingleAddress(
                    address: snapshot.data![index],
                    onTap: () async {
                      await selectAddress(snapshot.data![index]);
                      Get.back();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Function to reset form fields
  resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
