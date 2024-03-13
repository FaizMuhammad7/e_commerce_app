import 'package:e_commerce_app/custom_widget/my_list_tile.dart';
import 'package:e_commerce_app/helpers/app_colors.dart';
import 'package:e_commerce_app/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckUserOrderDetails extends StatelessWidget {
  var id;
  OrderModel orderModel;

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
                orderModel.productImage,
                fit: BoxFit.cover,
              ),
            ).paddingOnly(top: 10),
            MyListTile(
              title: Text(
                orderModel.productName,
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
                orderModel.productDes == ""
                    ? "Bhot hi achy han eik dam brand la jaw-ab Quality hy"
                    : orderModel.productDes,
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
                orderModel.productQuantity.toString(),
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
                orderModel.productPrice.toString(),
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
                orderModel.customerName,
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
                orderModel.customerAddress,
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
                orderModel.customerPhone,
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

  CheckUserOrderDetails({
    required this.id,
    required this.orderModel,
  });
}
