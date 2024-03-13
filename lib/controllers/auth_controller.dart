import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../helpers/app_colors.dart';
import '../models/user_model.dart';


class AuthController extends GetxController {
  var isLoading = false.obs;
  var obscureText1 = false.obs;
  var obscureText2 = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController retypePC = TextEditingController();

  /// Signup Method
  Future<void> signUp() async {
    isLoading.value = true;
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailC.text,
      password: passwordC.text,
    )
        .then(
      (value) async {
        isLoading.value = false;
        Get.snackbar(
          "Sign UP",
          "Successfully Sign Up",
          backgroundColor: AppColors.bgAppColor,
          borderRadius: 8.0,
        );
        var userObj = UserModel(
          name: nameC.text,
          email: emailC.text,
          password: passwordC.text,
          user_id: AuthConstants.currentUserId.toString(),
          imageUrl: "",
          createdOn: DateTime.now().toString(),
          isAdmin: false,
          isActive: true,
        );
        await saveUserData(userObj);
      },
    ).onError(
      (error, stackTrace) {
        isLoading.value = false;
        Get.snackbar(
          "Error",
          error.toString(),
          backgroundColor: AppColors.bgAppColor,
          borderRadius: 8.0,
        );
      },
    );
  }

  /// SignIn Method
  Future<void> logIn() async {
    isLoading.value = true;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailC.text,
      password: passwordC.text,
    )
        .then(
      (value) {
        isLoading.value = false;
      },
    ).onError(
      (error, stackTrace) {
        isLoading.value = false;
      },
    );
  }

  /// SignOut Method
  Future<void> signOut() async {
    isLoading.value = true;
    await FirebaseAuth.instance.signOut();
  }

  /// save user data Method
  Future<void> saveUserData(UserModel userModel) async {
    await DbConstants.usersRef.doc(AuthConstants.currentUserId.toString()).set(
          userModel.toMap(),
        );
  }

  Future<void> forgetPassword(String email) async {
    try {
      EasyLoading.show(status: "Please wait...");
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      EasyLoading.dismiss();
    } on FirebaseException catch (e) {
      print(e);
      EasyLoading.showToast(e.toString());
    }
  }

  void toggleVisibility1() {
    obscureText1.value = !obscureText1.value;
  }

  void toggleVisibility2() {
    obscureText2.value = !obscureText2.value;
  }
}
