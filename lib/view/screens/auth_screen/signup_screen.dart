import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:e_commerce_app/custom_widget/my_e_button.dart';
import 'package:e_commerce_app/view/screens/auth_screen/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom_widget/my_text_field.dart';
import '../../../helpers/app_colors.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: AppColors.bgAppColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome!",
              style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins_SemiBold"),
            ).paddingOnly(top: 60),
            Text(
              "We are glad that you here",
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 12,
                fontFamily: "Poppins_Regular",
                fontWeight: FontWeight.w500,
              ),
            ).paddingOnly(top: 10),
            MyTextField(
              controller: controller.nameC,
              keyboardType: TextInputType.name,
              hintText: "Enter your name",
              hintStyle: TextStyle(
                  color: AppColors.textColor.withOpacity(.8),
                  fontFamily: "Poppins_Regular",
                  fontSize: 12),
              field: true,
              fillColor: AppColors.textGreyColor.withOpacity(.2),
            ).paddingOnly(top: 60),
            MyTextField(
              controller: controller.emailC,
              keyboardType: TextInputType.emailAddress,
              hintText: "Enter your Email",
              hintStyle: TextStyle(
                  color: AppColors.textColor.withOpacity(.8),
                  fontFamily: "Poppins_Regular",
                  fontSize: 12),
              field: true,
              fillColor: AppColors.textGreyColor.withOpacity(.2),
            ).paddingOnly(top: 10),
            Obx(() {
              return MyTextField(
                controller: controller.passwordC,
                keyboardType: TextInputType.visiblePassword,
                obscureText: controller.obscureText1.value,
                SuffixIcon: IconButton(
                  icon: Icon(
                    controller.obscureText1.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    controller.toggleVisibility1();
                  },
                ),
                hintText: "Enter your password",
                hintStyle: TextStyle(
                    color: AppColors.textColor.withOpacity(.8),
                    fontFamily: "Poppins_Regular",
                    fontSize: 12),
                field: true,
                fillColor: AppColors.textGreyColor.withOpacity(.2),
              );
            }).paddingOnly(top: 10),
            Obx(() {
              return MyTextField(
                controller: controller.retypePC,
                keyboardType: TextInputType.visiblePassword,
                obscureText: controller.obscureText2.value,
                SuffixIcon: IconButton(
                  icon: Icon(
                    controller.obscureText2.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    controller.toggleVisibility2();
                  },
                ),
                hintText: "Enter your confirm password",
                hintStyle: TextStyle(
                    color: AppColors.textColor.withOpacity(.8),
                    fontFamily: "Poppins_Regular",
                    fontSize: 12),
                field: true,
                fillColor: AppColors.textGreyColor.withOpacity(.2),
              );
            }).paddingOnly(top: 10),
            MyButton(
              Text: Obx(() {
                return controller.isLoading.value == false
                    ? Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins_Regular",
                            fontSize: 14),
                      )
                    : SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.bgAppColor,
                          strokeWidth: 3,
                        ),
                      );
              }),
              onPressed: () async {
                await controller.signUp();
                Get.to(() => LoginScreen());
                controller.nameC.clear();
                controller.emailC.clear();
                controller.passwordC.clear();
                controller.retypePC.clear();
              },
              bgColor: AppColors.textColor,
              buttonSize: Size(280, 44),
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ).paddingOnly(top: 100),
            RichText(
              text: TextSpan(
                text: "Already have an account? ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: "Poppins_Regular",
                ),
                children: [
                  TextSpan(
                      text: "Sign In",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontFamily: "Poppins_SemiBold",
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        decorationColor: AppColors.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => LoginScreen());
                        },
                  ),
                ],
              ),
            ).paddingOnly(top: 12),
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 10),
      ),
    );
  }
}
