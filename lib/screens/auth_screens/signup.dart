import 'package:e_commerce_app/core/constants/size.dart';
import 'package:e_commerce_app/core/constants/text_strings.dart';
import 'package:e_commerce_app/screens/widgets/form_divider.dart';
import 'package:e_commerce_app/screens/widgets/signup_form.dart';
import 'package:e_commerce_app/screens/widgets/social_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(HkSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                HkTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: HkSizes.spaceBtwSections),

              /// Form
              const HkSignUpForm(),

              /// Divider
              HkFormDivider(dividerText: HkTexts.orSignUpWith.capitalize!),
              const SizedBox(height: HkSizes.spaceBtwSections),

              /// Social Buttons
              const HkSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
