import 'package:e_commerce_app/controllers/cart_item_controller.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom_widget/my_e_button.dart';
import '../../../helpers/app_colors.dart';
import 'place_order_screen.dart';

class AddToCartScreen extends StatelessWidget {
  ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartItemController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network(
                productModel.productImage.toString(),
                fit: BoxFit.cover,
              ),
              color: Colors.grey.withOpacity(.5),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productModel.productName,
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "${"\$ ${productModel.productPrice}"}",
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ).paddingOnly(top: 6),
                  Row(
                    children: [
                      Text(
                        productModel.productName,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ).paddingOnly(right: 20),
                      Text(
                        productModel.pQuantity,
                        style:
                            TextStyle(color: AppColors.textColor, fontSize: 12),
                      ),
                    ],
                  ).paddingOnly(top: 3, bottom: 6),
                  Text(
                    "Description",
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ).paddingOnly(bottom: 4),
                  Text(
                    productModel.productDes,
                    style: TextStyle(color: AppColors.textColor, fontSize: 12),
                  ).paddingOnly(bottom: 20),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Price",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "\$${productModel.productPrice}",
                      style: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ).paddingOnly(bottom: 6),
                  ],
                ),
                MyButton(
                  Text: Text(
                    "Add to Cart",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    controller.checkProductExist(productModel);
                    Get.to(() => PlaceOrderScreen());
                  },
                  bgColor: Colors.brown,
                  buttonSize: Size(170, 44),
                  shapeBorder: StadiumBorder(),
                ),
              ],
            ).paddingOnly(left: 6, right: 6, bottom: 20),
          ],
        ).paddingAll(10),
      ),
    );
  }

  AddToCartScreen({
    required this.productModel,
  });
}
