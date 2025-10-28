import 'package:e_commerce_app/controller/login_controller.dart';
import 'package:e_commerce_app/core/constants/image_strings.dart';
import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/constants/text_strings.dart';
import 'package:e_commerce_app/core/helper/helper_functions.dart';
import 'package:e_commerce_app/core/helper/validation.dart';
import 'package:e_commerce_app/core/styles/spacing_styles.dart';
import 'package:e_commerce_app/data/repositories/forget_passwrod.dart';
import 'package:e_commerce_app/screens/auth_screens/signup.dart';
import 'package:e_commerce_app/screens/widgets/form_divider.dart';
import 'package:e_commerce_app/screens/widgets/social_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: HkSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Logo , Title And Subtitle
              const HkLoginHeader(),

              /// Form
              const HkLoginForm(),

              /// Divider
              HkFormDivider(dividerText: HkTexts.orSignInWith.capitalize!),
              const SizedBox(height: HkSizes.spaceBtwSections),

              /// Footer
              const HkSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class HkLoginForm extends StatelessWidget {
  const HkLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: HkSizes.spaceBtwSections),
        child: Column(
          children: [
            /// Email
            TextFormField(
              controller: controller.email,
              validator: (value) => HkValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: HkTexts.email,
              ),
            ),
            const SizedBox(height: HkSizes.spaceBtwInputFields),

            /// Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) =>
                    HkValidator.validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: HkTexts.password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                    ),
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                  ),
                ),
              ),
            ),
            const SizedBox(height: HkSizes.spaceBtwInputFields / 2),

            /// Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Remember Me
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value,
                      ),
                    ),
                    const Text(HkTexts.rememberMe),
                  ],
                ),

                /// Forget Password
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Get.to(() => const ForgetPassScreen()),
                      child: const Text(
                        HkTexts.forgetPassword,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: HkSizes.spaceBtwSections),

            /// Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: const Text(HkTexts.signIn),
              ),
            ),
            const SizedBox(height: HkSizes.spaceBtwItems),

            /// Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignUpScreen()),
                child: const Text(HkTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HkLoginHeader extends StatelessWidget {
  const HkLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HkHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 80,
          image: AssetImage(
            dark ? HkImages.lightAppLogo : HkImages.darkAppLogo,
          ),
        ),
        const SizedBox(height: HkSizes.spaceBtwItems),
        Text(
          HkTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: HkSizes.sm),
        Text(
          HkTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
