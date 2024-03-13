import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../helpers/firebase_helpers.dart';

class GetTotalUserOrder extends GetxController {
  RxInt orderLength = RxInt(0);
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subscription;

  @override
  void onInit() {
    super.onInit();
    _subscription = DbConstants.orderRef
        .doc(AuthConstants.currentUserId)
        .collection("confirmOrders")
        .where("status", isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      orderLength.value = snapshot.size;
    });
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}

class GetTotalUserOrderCart extends GetxController {
  RxInt cartOrderLength = RxInt(0);
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
      _cartSubscription;

  @override
  void onInit() {
    super.onInit();
    _cartSubscription = DbConstants.cartRef
        .doc(AuthConstants.currentUserId)
        .collection("cartOrders")
        .snapshots()
        .listen((snapshot) {
      cartOrderLength.value = snapshot.size;
    });
  }

  @override
  void onClose() {
    _cartSubscription?.cancel();
    super.onClose();
  }
}
