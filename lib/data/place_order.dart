import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/order_successful_submit.dart';
import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:e_commerce_app/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../helpers/generate_order_id.dart';

void placeOrder({
  required String customerName,
  required String customerPhone,
  required String customerAddress,
  User? current_user,
}) async {
  EasyLoading.show(status: "Please Wait........");
  if (current_user != null) {
    try {
      QuerySnapshot querySnapshot = await DbConstants.cartRef
          .doc(AuthConstants.currentUserId)
          .collection("cartOrders")
          .get();
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (var doc in documents) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
        String orderId = generateOrderId();

        OrderModel orderModel = OrderModel(
          productId: data["productId"],
          categoryId: data["categoryId"],
          productName: data["productN"],
          categoryName: data["categoryN"],
          productPrice: data["productPr"],
          productImage: data["productImage"],
          deliveryTime: data["deliveryTime"],
          createdAt: DateTime.now().toString(),
          updatedAt: data["updateOn"],
          productQuantity: data["productQ"],
          status: false,
          customerAddress: customerAddress,
          customerId: AuthConstants.currentUserId.toString(),
          customerName: customerName,
          customerPhone: customerPhone,
          productDes: data["productDes"] ?? "",
        );

        for (var x = 0; x < documents.length; x++) {
          await DbConstants.orderRef.doc(AuthConstants.currentUserId).set({
            "user_id": AuthConstants.currentUserId,
            "customerName": customerName,
            "customerPhone": customerPhone,
            "customerAddress": customerAddress,
            "orderStatus": false,
            "createdAt": DateTime.now()
          });

          // upload orders
          await DbConstants.orderRef
              .doc(AuthConstants.currentUserId)
              .collection("confirmOrders")
              .doc(orderId)
              .set(orderModel.toMap());

          // delete cart products
          await DbConstants.cartRef
              .doc(AuthConstants.currentUserId)
              .collection("cartOrders")
              .doc(orderModel.productId.toString())
              .delete()
              .then((value) {
            print("Delete cart products ${orderModel.productId.toString()}");
          });
        }
      }
      print("order confirmed");
      Get.snackbar("Order confirmed", "Thank you for your order",
          backgroundColor: Colors.red, colorText: Colors.white);
      EasyLoading.dismiss();
      Get.to(() => OrderSuccessfulSubmit());
    } catch (e) {
      print("Error: $e");
      print("Error: Occur");
      EasyLoading.dismiss();
    }
  } else {
    print("user null");
    EasyLoading.dismiss();
  }
}
