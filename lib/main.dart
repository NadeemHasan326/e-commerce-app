import 'package:e_commerce_app/core/theme/theme.dart';
import 'package:e_commerce_app/screens/auth_screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E Commerce',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: HkAppTheme.lightTheme,
      darkTheme: HkAppTheme.darkTheme,
      home: OnBoardingScreen(),
    );
  }
}
