import 'package:e_commerce_app/custom_widget/my_e_button.dart';
import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_item_controller.dart';
import '../../../custom_widget/my_text_field.dart';
import '../../../data/place_order.dart';
import '../../../helpers/app_colors.dart';
import '../../../models/cart_model.dart';


class PlaceOrderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cartPriceController = Get.put(CartPriceController());
    return Scaffold(
      backgroundColor: AppColors.bgAppColor,
      appBar: AppBar(
        title: Text(
          "Place Order Screen",
          style: TextStyle(
            color: AppColors.textColor,
            fontFamily: "Poppins_SemiBold",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.bgAppColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 10,
            width: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: AppColors.textGreyColor.withOpacity(.3),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ).paddingAll(10),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select All",
                  style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.delete,
                    color: Colors.brown,
                  ),
                ),
              ],
            ).paddingOnly(top: 20),
            StreamBuilder(
              stream: DbConstants.cartRef
                  .doc(AuthConstants.currentUserId)
                  .collection("cartOrders")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: AppColors.textColor,
                        strokeWidth: 3,
                      ),
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: Text("No Products found!"),
                  );
                }

                   return ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var mapData = snapshot.data!.docs[index];

                    var item = CartModel(
                      productId: mapData["productId"],
                      categoryId: mapData["categoryId"],
                      productN: mapData["productN"],
                      categoryN: mapData["categoryN"],
                      productPr: mapData["productPr"],
                      productImage: mapData["productImage"],
                      deliveryTime: mapData["deliveryTime"],
                      createdAt: mapData["createdAt"],
                      updateOn: mapData["updateOn"],
                      productQ: mapData["productQ"],
                      productTotalPrice:
                          double.parse(mapData["productTotalPrice"].toString()),
                    );

                    /// calculate total price just call
                    cartPriceController.fetchProductPrice();

                    // var item = data[index];
                    return SwipeActionCell(
                      key: ObjectKey(item.productId),
                      trailingActions: [
                        SwipeAction(
                          title: "Delete",
                          forceAlignmentToBoundary: true,
                          performsFirstActionWithFullSwipe: true,
                          onTap: (CompletionHandler handler) async {
                            await DbConstants.cartRef
                                .doc(AuthConstants.currentUserId)
                                .collection("cartOrders")
                                .doc(item.productId)
                                .delete();
                          },
                        ),
                      ],
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 240,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(.5),
                            ),
                            child: Row(
                              children: [
                                Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(.5),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          item.productImage,
                                          fit: BoxFit.cover,
                                        ))),
                                SizedBox(width: 7),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.productN,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Color : ${item.categoryN}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 10),
                                    ),
                                    Text(
                                      "Size    : ${item.productQ}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 10),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "\$ ${item.productTotalPrice}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ).paddingOnly(right: 20),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                if (item.productQ > 1) {
                                                  await DbConstants.cartRef
                                                      .doc(AuthConstants
                                                          .currentUserId)
                                                      .collection("cartOrders")
                                                      .doc(item.productId)
                                                      .update({
                                                    "productQ":
                                                        item.productQ - 1,
                                                    "productTotalPrice":
                                                        (double.parse(item
                                                                .productPr) *
                                                            (item.productQ -
                                                                1)),
                                                  });
                                                }
                                              },
                                              child: CircleAvatar(
                                                radius: 10,
                                                backgroundColor: Colors.white,
                                                child: Text(
                                                  "-",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ).paddingOnly(right: 5),
                                            ),
                                            Text(
                                              item.productQ.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                if (item.productQ > 0) {
                                                  await DbConstants.cartRef
                                                      .doc(AuthConstants
                                                          .currentUserId)
                                                      .collection("cartOrders")
                                                      .doc(item.productId)
                                                      .update({
                                                    "productQ":
                                                        item.productQ + 1,
                                                    "productTotalPrice":
                                                        double.parse(item
                                                                .productPr) *
                                                            (item.productQ + 1)
                                                  });
                                                }
                                              },
                                              child: CircleAvatar(
                                                radius: 10,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.black,
                                                  size: 14,
                                                ),
                                              ).paddingOnly(left: 5),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ).paddingOnly(top: 7),
                                  ],
                                ).paddingOnly(top: 9),
                              ],
                            ).paddingSymmetric(horizontal: 7),
                          ),
                        ],
                      ),
                    ).paddingOnly(top: 30);
                  },
                );
              },
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
                    Obx(() {
                      return Text(
                        "\$${cartPriceController.totalPrice.value.toString()}",
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      );
                    }).paddingOnly(bottom: 6),
                  ],
                ),
                MyButton(
                  Text: Text(
                    "Check out order",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    showCustomBottomSheet();
                    // Get.to(() => CheckOutScreen());
                  },
                  bgColor: Colors.brown,
                  buttonSize: Size(170, 44),
                  shapeBorder: StadiumBorder(),
                ),
              ],
            ).paddingOnly(top: 140, left: 6, right: 6),
          ],
        ).paddingSymmetric(horizontal: 10),
      ),
    );
  }
  void showCustomBottomSheet() {
    var cartPriceController = Get.put(CartPriceController());
    Get.bottomSheet(
      Container(
        height: Get.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
                child: MyTextField(
                  field: true,
                  fillColor: AppColors.textGreyColor.withOpacity(.2),
                  keyboardType: TextInputType.name,
                  controller: cartPriceController.nameController,
                  hintStyle: TextStyle(
                      color: AppColors.textColor.withOpacity(.8),
                      fontFamily: "Poppins_Regular",
                      fontSize: 12),
                  hintText: "Name",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
                child: MyTextField(
                  field: true,
                  fillColor: AppColors.textGreyColor.withOpacity(.2),
                  keyboardType: TextInputType.phone,
                  controller: cartPriceController.phoneController,
                  hintText: "Phone",
                  hintStyle: TextStyle(
                      color: AppColors.textColor.withOpacity(.8),
                      fontFamily: "Poppins_Regular",
                      fontSize: 12),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
                child: MyTextField(
                  fillColor: AppColors.textGreyColor.withOpacity(.2),
                  field: true,
                  hintStyle: TextStyle(
                      color: AppColors.textColor.withOpacity(.8),
                      fontFamily: "Poppins_Regular",
                      fontSize: 12),
                  controller: cartPriceController.addressController,
                  keyboardType: TextInputType.streetAddress,
                  hintText: "Address",
                ),
              ),
              MyButton(
                Text: Text("Place Order",style: TextStyle(color: AppColors.naturalLight),),
                onPressed: () async {
                  User? user = AuthConstants.currentUser;
                  var name = cartPriceController.nameController.text;
                  var phone = cartPriceController.phoneController.text;
                  var address = cartPriceController.addressController.text;
                  if (name != "" && phone != "" && address != "") {
                    placeOrder(
                      customerName: name,
                      customerPhone: phone,
                      customerAddress: address,
                      current_user: user,
                    );
                    print(user!.uid);
                  } else {
                    print("please fill all details");
                  }
                },
                bgColor: Colors.red,
                buttonSize: Size(200, 46),
                shapeBorder: StadiumBorder(),
              ).paddingAll(12),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      elevation: 0,
    );
  }
}
