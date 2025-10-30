import 'package:e_commerce_app/controller/address_controller.dart';
import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/constants/image_strings.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/helper/animation_loader.dart';
import 'package:e_commerce_app/core/utils/cloud_helper_functions.dart';
import 'package:e_commerce_app/screens/add_new_address_screen.dart';
import 'package:e_commerce_app/screens/widgets/appbar.dart';
import 'package:e_commerce_app/screens/widgets/single_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: HkAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(HkSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllUserAddresses(),
              builder: (context, snapshot) {
                /// Handle loader, no record, error message
                const emptyWidget = HkAnimationLoader(
                  text: 'Whoops! Address is not available...',
                  animation: HkImages.pencilAnimation,
                  showAction: false,
                );
                final widget = HkCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  nothingFound: emptyWidget,
                );
                if (widget != null) return widget;

                /// Record Found
                final addresses = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  itemBuilder: (context, index) => HkSingleAddress(
                    address: addresses[index],
                    onTap: () => controller.selectAddress(addresses[index]),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: HkColors.primary,
        child: const Icon(Iconsax.add, color: HkColors.white),
      ),
    );
  }
}
