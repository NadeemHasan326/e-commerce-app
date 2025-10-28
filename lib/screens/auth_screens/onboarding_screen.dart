import 'package:e_commerce_app/controller/onboarding_controller.dart';
import 'package:e_commerce_app/core/constants/app_color.dart';
import 'package:e_commerce_app/core/constants/image_strings.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/constants/text_strings.dart';
import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:e_commerce_app/core/utils/device_utility.dart';
import 'package:e_commerce_app/screens/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          /// Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: HkImages.onBoardingImage1,
                title: HkTexts.onBoardingTitle1,
                subtitle: HkTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: HkImages.onBoardingImage2,
                title: HkTexts.onBoardingTitle2,
                subtitle: HkTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: HkImages.onBoardingImage3,
                title: HkTexts.onBoardingTitle3,
                subtitle: HkTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          /// Skip Button
          Positioned(
            top: HkDeviceUtils.getAppBarHeight(),
            right: HkSizes.defaultSpace,
            child: TextButton(
              onPressed: () => controller.skipPage(),
              child: const Text('Skip'),
            ),
          ),

          /// Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          /// Circular Button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HkHelperFunctions.isDarkMode(context);
    final controller = Get.put(OnBoardingController());

    return Positioned(
      bottom: HkDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: HkSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: ExpandingDotsEffect(
          dotHeight: 6,
          activeDotColor: dark ? HkColors.light : HkColors.dark,
        ),
      ),
    );
  }
}

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HkHelperFunctions.isDarkMode(context);
    final controller = Get.put(OnBoardingController());

    return Positioned(
      bottom: HkDeviceUtils.getBottomNavigationBarHeight(),
      right: HkSizes.defaultSpace,
      child: ElevatedButton(
        onPressed: () => controller.nextPage(),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: dark ? HkColors.primary : HkColors.black,
        ),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
