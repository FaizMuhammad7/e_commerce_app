import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:e_commerce_app/custom_widget/my_e_button.dart';
import 'package:e_commerce_app/custom_widget/my_text_field.dart';
import 'package:e_commerce_app/helpers/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: AppColors.bgAppColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Text(
            "Forgot Password ?",
            style: TextStyle(
                color: AppColors.textColor,
                fontSize: 28,
                fontFamily: "Poppins_SemiBold"),
          ).paddingOnly(top: 60),
          Image.asset(
            "assets/images/password_screen_picture.png",
            height: 200,
            width: 190,
          ).paddingOnly(top: 10),
          Text(
            "Please, enter your email address. You will receive ",
            style: TextStyle(
              color: AppColors.textColor,
              fontFamily: "Poppins_Regular",
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ).paddingOnly(top: 30),
          Text(
            "a link to create a new password via email.",
            style: TextStyle(
              color: AppColors.textColor,
              fontFamily: "Poppins_Regular",
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          MyTextField(
            hintText: "Enter your Email",
            controller: controller.emailC,
            keyboardType: TextInputType.emailAddress,
            PrefixIcon: Icon(
              Icons.email_outlined,
              color: AppColors.textColor,
              size: 20,
            ),
            hintStyle: TextStyle(
                color: AppColors.textColor.withOpacity(.8),
                fontFamily: "Poppins_Regular",
                fontSize: 12),
            field: true,
            fillColor: AppColors.textGreyColor.withOpacity(.2),
          ).paddingOnly(
            top: 50,
          ),
          MyButton(
            Text: Text(
              "Change Password",
              style: TextStyle(
                color: AppColors.bgAppColor,
                fontFamily: "Poppins_Regular",
                fontSize: 12,
              ),
            ),
            onPressed: () {
              String email = controller.emailC.toString().trim();
              controller.forgetPassword(email);
            },
            bgColor: Colors.black,
            buttonSize: Size(280, 46),
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ).paddingOnly(top: 120),
        ],
      ).paddingAll(12),
    );
  }
}
