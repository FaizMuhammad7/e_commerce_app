import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';

class CartItemController extends GetxController {

  var isProductInCart = false.obs;

  /// check product exist or not
  Future<bool> checkProductExist(ProductModel productModel,
      {int quantityIncrement = 1}) async {
    DocumentReference documentReference = DbConstants.cartRef
        .doc(AuthConstants.currentUserId)
        .collection("cartOrders")
        .doc(productModel.productId);
    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      int currentQuantity = snapshot["productQ"];
      int updatedQuantity = currentQuantity + quantityIncrement;
      double totalPrice =
          double.parse(productModel.productPrice) * updatedQuantity;
      await documentReference.update({
        "pQuantity": updatedQuantity,
        "productTotalPrice": totalPrice,
      });
      print("product exist");
    } else {
      await DbConstants.cartRef.doc(AuthConstants.currentUserId).set({
        "user_id": AuthConstants.currentUserId,
        "createdAt": DateTime.now(),
      });

      CartModel cartModel = CartModel(
        productId: productModel.productId,
        categoryId: productModel.categoryId,
        productN: productModel.productName,
        categoryN: productModel.categoryName,
        productPr: productModel.productPrice,
        productImage: productModel.productImage,
        deliveryTime: productModel.pDeliveryTime,
        productTotalPrice: double.parse(productModel.productPrice),
        createdAt: DateTime.now().toString(),
        updateOn: DateTime.now().toString(),
        productQ: 1,
      );
      await documentReference.set(cartModel.toMap());
      print("product add");
    }
    return snapshot.exists;
  }
}

class CartPriceController extends GetxController {
  RxDouble totalPrice = 0.0.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void onInit() {
    fetchProductPrice();
    super.onInit();
  }

  Future<void> fetchProductPrice() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await DbConstants
        .cartRef
        .doc(AuthConstants.currentUserId)
        .collection("cartOrders")
        .get();
    double sum = 0.0;

    for (final doc in snapshot.docs) {
      final data = doc.data();
      if (data != null && data.containsKey("productTotalPrice")) {
        sum += (data["productTotalPrice"] as num).toDouble();
      }
    }
    totalPrice.value = sum;
  }
}
