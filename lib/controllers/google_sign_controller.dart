import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final auth = FirebaseAuth.instance;

  /// google signIn Method
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        EasyLoading.show(status: "Please wait...");
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          var userObj = UserModel(
            name: user.displayName.toString(),
            email: user.email.toString(),
            password: '',
            user_id: user.uid,
            imageUrl: user.photoURL.toString(),
            createdOn: DateTime.now().toString(),
            isAdmin: false,
            isActive: true,
          );

          await DbConstants.usersRef.doc(user.uid).set(userObj.toMap());

          EasyLoading.dismiss();
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", e.toString());
    }
  }

  /// google signOut
  Future<void> googleSignOut() async {
    await googleSignIn.signOut();
  }

}
