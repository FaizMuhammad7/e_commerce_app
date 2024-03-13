import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:get/get.dart';

class GetAllUserController extends GetxController {
  final RxInt userLength = RxInt(0);
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      _userControllerSubscription;

  @override
  void onInit() {
    super.onInit();
    _userControllerSubscription = DbConstants.usersRef
        .where("isAdmin", isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
          userLength.value = snapshot.size;
    });
  }

  @override
  void onClose() {
    _userControllerSubscription.cancel();
    super.onInit();
  }
}
