import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:get/get.dart';

class GetUserDataController extends GetxController {
  Future<List<QueryDocumentSnapshot<Object?>>> getUserData(
      String userId) async {
    final QuerySnapshot userData =
        await DbConstants.usersRef.where("user_id", isEqualTo: userId).get();
    return userData.docs;
  }
}
