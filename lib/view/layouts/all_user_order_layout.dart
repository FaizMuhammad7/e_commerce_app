import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/app_colors.dart';
import '../../controllers/cart_item_controller.dart';
import '../../controllers/get_total_user_order.dart';
import '../../custom_widget/my_e_button.dart';
import '../../custom_widget/my_text_field.dart';
import '../../data/place_order.dart';
import '../screens/product_screen/check_user_order_cart_details.dart';

class AllUserOrderLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cartController = Get.put(GetTotalUserOrderCart());
    var cartPriceController = Get.put(CartPriceController());
    return Scaffold(
      backgroundColor: AppColors.bgAppColor,
      appBar: AppBar(
        title: Text(
          "All User Orders",
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Poppins_Regular",
            color: AppColors.textColor,
          ),
        ),
        backgroundColor: AppColors.bgAppColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: StreamBuilder(
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
                    child: Text("No Orders found!"),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var mapData = snapshot.data!.docs[index];

                    CartModel cartModel = CartModel(
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
                      productTotalPrice: mapData["productTotalPrice"],
                    );

                    // OrderModel orderModel = OrderModel(
                    //   customerName: mapData["customerName"],
                    //   productDes: mapData["productDes"],
                    //   customerPhone: mapData["customerPhone"],
                    //   customerId: mapData["customerId"],
                    //   customerAddress: mapData["customerAddress"],
                    //   status: mapData["status"],
                    //   categoryId: mapData["categoryId"],
                    //   categoryName: mapData["categoryName"],
                    //   createdAt: mapData["createdAt"],
                    //   deliveryTime: mapData["deliveryTime"],
                    //   productId: mapData["productId"],
                    //   productImage: mapData["productImage"],
                    //   productName: mapData["productName"],
                    //   productPrice: mapData["productPrice"],
                    //   productQuantity: mapData["productQuantity"],
                    //   updatedAt: mapData["updatedAt"],
                    // );

                    return Column(
                      children: [
                        Card(
                          child: ListTile(
                            title: Text(
                              cartModel.productN,
                              style: TextStyle(
                                fontFamily: "Poppins_Regular",
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              cartModel.productQ.toString(),
                              style: TextStyle(
                                fontFamily: "Poppins_Regular",
                                fontSize: 14,
                                color: Colors.brown,
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  NetworkImage(cartModel.productImage),
                            ),
                            onTap: () {
                              Get.to(
                                () => CheckUserOrderCartDetails(
                                  id: cartModel.productId,
                                  cartModel: cartModel,
                                ),
                              );
                            },
                            trailing: Text(
                              cartModel.productTotalPrice.toString(),
                              style: TextStyle(
                                fontFamily: "Poppins_Regular",
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          cartController.cartOrderLength.value == 0
              ? SizedBox()
              : Row(
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
                ).paddingOnly(bottom: 30),
        ],
      ).paddingSymmetric(horizontal: 10),
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
                Text: Text(
                  "Place Order",
                  style: TextStyle(color: AppColors.naturalLight),
                ),
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
