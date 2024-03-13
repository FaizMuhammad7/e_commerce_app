import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:e_commerce_app/custom_widget/my_e_button.dart';
import 'package:e_commerce_app/view/screens/auth_screen/forgot_password_screen.dart';
import 'package:e_commerce_app/view/screens/auth_screen/signup_screen.dart';
import 'package:e_commerce_app/view/screens/product_screen/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/google_sign_controller.dart';
import '../../../custom_widget/my_text_field.dart';
import '../../../helpers/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: AppColors.bgAppColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "Sign In",
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins_SemiBold"),
                ).paddingOnly(top: 60),
                Text(
                  "Hi! Welcome back, you've been missed",
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 12,
                    fontFamily: "Poppins_Regular",
                    fontWeight: FontWeight.w500,
                  ),
                ).paddingOnly(top: 10),
                MyTextField(
                  hintText: "Enter your Email",
                  controller: controller.emailC,
                  keyboardType: TextInputType.emailAddress,
                  hintStyle: TextStyle(
                      color: AppColors.textColor.withOpacity(.8),
                      fontFamily: "Poppins_Regular",
                      fontSize: 12),
                  field: true,
                  fillColor: AppColors.textGreyColor.withOpacity(.2),
                ).paddingOnly(top: 60),
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
                }).paddingOnly(top: 10, bottom: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => ForgotPasswordScreen());
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontFamily: "Poppins_Regular",
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          decorationColor: AppColors.textColor,
                          decorationThickness: 2),
                    ),
                  ),
                ),
                MyButton(
                  Text: Obx(
                    () {
                      return controller.isLoading.value == false
                          ? Text(
                              "Sign In",
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
                    },
                  ),
                  onPressed: () async {
                    await controller.logIn();
                    Get.to(() => HomeScreen());
                    controller.emailC.clear();
                    controller.passwordC.clear();
                  },
                  bgColor: AppColors.textColor,
                  buttonSize: Size(280, 44),
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ).paddingOnly(top: 50, bottom: 18),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Divider(
                        indent: 20,
                        endIndent: 20,
                      ),
                    ),
                    Text("or"),
                    Expanded(
                      child: Divider(
                        indent: 20,
                        endIndent: 20,
                      ),
                    ),
                  ],
                ),
                MyButton(
                  Text: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/google.png",
                        height: 20,
                        width: 20,
                      ).paddingOnly(right: 7),
                      Text(
                        "Log In with Google",
                        style: TextStyle(
                          color: AppColors.textColor.withOpacity(.8),
                          fontFamily: "Poppins_Regular",
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                   await GoogleAuthController().signInWithGoogle();
                    Get.to(() => HomeScreen());
                  },
                  bgColor: AppColors.bgAppColor,
                  buttonSize: Size(280, 44),
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ).paddingOnly(top: 25),
              ],
            ),
          ),
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
                    text: "Sign Up",
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
                        Get.to(() => SignUpScreen());
                      }),
              ],
            ),
          ).paddingAll(12),
        ],
      ).paddingSymmetric(horizontal: 20, vertical: 10),
    );
  }
}
