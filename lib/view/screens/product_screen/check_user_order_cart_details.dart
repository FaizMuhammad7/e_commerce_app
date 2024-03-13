import 'package:e_commerce_app/custom_widget/my_list_tile.dart';
import 'package:e_commerce_app/helpers/app_colors.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckUserOrderCartDetails extends StatelessWidget {
  var id;
  CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Poppins_SemiBold",
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
        backgroundColor: AppColors.bgAppColor,
      ),
      backgroundColor: AppColors.bgAppColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.textGreyColor.withOpacity(.03),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(
                cartModel.productImage,
                fit: BoxFit.cover,
              ),
            ).paddingOnly(top: 10),
            MyListTile(
              title: Text(
                cartModel.productN,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins_SemiBold",
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
            MyListTile(
              title: Text(
                "Bhot hi achy han eik dam brand la jaw-ab Quality hy",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins_SemiBold",
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
            MyListTile(
              title: Text(
                cartModel.productQ.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins_SemiBold",
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
            MyListTile(
              title: Text(
                cartModel.productTotalPrice.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins_SemiBold",
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ).paddingAll(12),
      ),
    );
  }

  CheckUserOrderCartDetails({
    required this.id,
    required this.cartModel,
  });
}
