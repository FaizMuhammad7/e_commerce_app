import 'dart:async';

import 'package:e_commerce_app/controllers/get_user_data_controller.dart';
import 'package:e_commerce_app/helpers/app_colors.dart';
import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:e_commerce_app/view/screens/auth_screen/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screens/admin_panel/admin_home_page.dart';
import '../view/screens/product_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        checkUser(context);
      },
    );
  }

  Future<void> checkUser(BuildContext context) async {
    if (AuthConstants.currentUser != null) {
      final userController = Get.put(GetUserDataController());
      var userData =
          await userController.getUserData(AuthConstants.currentUserId!);
      if (userData[0]["isAdmin"] == true) {
        Get.offAll(() => AdminHomePage());
      } else {
        Get.offAll(() => HomeScreen());
      }
    } else {
      Get.to(() => OnBoardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgAppColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/splash_screen_image.png"),
              height: 200,
              width: 200,
            ),
            SizedBox(height: 20),
            Text(
              ' E Commerce App',
              style: TextStyle(
                fontSize: 24,
                color: AppColors.textColor,
                fontFamily: "Poppins_Regular",
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
