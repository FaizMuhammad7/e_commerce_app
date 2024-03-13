import 'package:e_commerce_app/helpers/app_colors.dart';
import 'package:e_commerce_app/view/screens/product_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_widget/my_e_button.dart';



class OrderSuccessfulSubmit extends StatelessWidget {
  const OrderSuccessfulSubmit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgAppColor,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image:
                    AssetImage("assets/images/order_successfully_submit.png"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Text(
                "Success!",
                style: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: "Poppins_SemiBold",
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                "Your order will be delivered soon",
                style: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: "Poppins_Regular",
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "Thank you for choosing our app!",
                style: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: "Poppins_Regular",
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
              MyButton(
                Text: Text(
                  "Continue Shopping",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Get.to(() => HomeScreen());
                },
                bgColor: Colors.red,
                buttonSize: Size(170, 42),
                shapeBorder: StadiumBorder(),
              ).paddingOnly(top: 15),
            ],
          ).paddingOnly(top: 100),
        ),
    );
  }
}
