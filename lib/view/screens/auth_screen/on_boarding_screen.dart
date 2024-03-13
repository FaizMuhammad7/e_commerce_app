import 'package:e_commerce_app/custom_widget/my_e_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/app_colors.dart';
import 'login_screen.dart';
import 'signup_screen.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/onBoarding_picture.png",
            height: 300,
            width: 250,
          ),
          Text(
            "Buy And Sell Anything Faster",
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins_SemiBold",
            ),
          ).paddingOnly(top: 10),
          Text(
            "With The Chunky App",
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins_SemiBold",
            ),
          ),
          Text(
            "Massive discounts and offers when you shope.",
            style: TextStyle(
                color: AppColors.textColor,
                fontSize: 10,
                fontWeight: FontWeight.w500),
          ).paddingOnly(top: 10),
          MyButton(
            Text: Text(
              "Sign In",
              style:
                  TextStyle(color: Colors.white, fontFamily: "Poppins_Regular"),
            ),
            onPressed: () {
              Get.to(() => LoginScreen());
            },
            bgColor: AppColors.textColor,
            buttonSize: Size(280, 46),
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ).paddingOnly(top: 70),
          MyButton(
            Text: Text(
              "Sign Up",
              style: TextStyle(
                color: AppColors.EButtonColor,
                fontFamily: "Poppins_Regular",
              ),
            ),
            onPressed: () {
              Get.to(() => SignUpScreen());
            },
            bgColor: Colors.white,
            buttonSize: Size(280, 46),
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: AppColors.EButtonColor,
              ),
            ),
          ).paddingOnly(top: 10),
        ],
      ).paddingSymmetric(horizontal: 16, vertical: 10),
    );
  }
}
