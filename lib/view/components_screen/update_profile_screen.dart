import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/controllers/admin_controller/upload_image_controller.dart';
import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:e_commerce_app/helpers/app_colors.dart';
import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../custom_widget/my_e_button.dart';
import '../../custom_widget/my_text_field.dart';
import '../../models/user_model.dart';
import '../layouts/profile_layout.dart';

class UpdateProfileScreen extends StatelessWidget {
  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    var uploadImageC = Get.put(UploadImageController());
    return Scaffold(
      backgroundColor: AppColors.bgAppColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Update your Profile",
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins_SemiBold",
            ),
          ).paddingOnly(top: 60),
          Obx(() {
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: uploadImageC.imageUrl.value.isEmpty
                      ? Image.asset(
                    "assets/images/place_holder.jpg",
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  )
                      : CachedNetworkImage(
                    imageUrl: uploadImageC.imageUrl.value.toString(),
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) {
                      return Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.brown,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 37,
                  bottom: 0,
                  left: 58,
                  child: GestureDetector(
                    child: Icon(
                      Icons.camera_alt,
                      color: AppColors.textColor,
                    ),
                    onTap: () async {
                      var result = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (result != null) {
                        var imagePath = result.path;
                        var id = UniqueKey()
                            .toString()
                            .replaceAll('[', "")
                            .replaceAll("]", "")
                            .replaceAll("#", "");
                        uploadImageC.imageUrl.value = await uploadImageC.uploadImage(
                          StorageConstants.profileRef,
                          imagePath,
                        );
                      };
                    },
                  ),
                ),
              ],
            );
          }).paddingOnly(top: 30),
          MyTextField(
            controller: controller.nameC,
            keyboardType: TextInputType.name,
            hintText: userModel.name,
            hintStyle: TextStyle(
                color: AppColors.textColor.withOpacity(.8),
                fontFamily: "Poppins_Regular",
                fontSize: 12),
            field: true,
            fillColor: AppColors.textGreyColor.withOpacity(.2),
          ).paddingOnly(top: 50),
          MyTextField(
            hintText: userModel.email,
            controller: controller.emailC,
            hintStyle: TextStyle(
                color: AppColors.textColor.withOpacity(.8),
                fontFamily: "Poppins_Regular",
                fontSize: 12),
            field: true,
            fillColor: AppColors.textGreyColor.withOpacity(.2),
          ).paddingOnly(top: 10),
          MyButton(
            Text: Text(
              "Update Profile",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins_Regular",
                  fontSize: 14),
            ),
            onPressed: () async {
              await DbConstants.usersRef
                  .doc(AuthConstants.currentUserId)
                  .update({
                "name": controller.nameC.text,
                "email": controller.emailC.text,
                "imageUrl": uploadImageC.imageUrl.value,
              });
              Get.to(() => ProfileLayout());
              Fluttertoast.showToast(
                  msg: "Update Successfully",
                  backgroundColor: Colors.brown,
                  textColor: AppColors.textColor);
              controller.nameC.clear();
              controller.emailC.clear();
            },
            bgColor: AppColors.textColor,
            buttonSize: Size(280, 44),
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ).paddingOnly(top: 100),
        ],
      ).paddingSymmetric(horizontal: 20, vertical: 10),
    );
  }

  UpdateProfileScreen({
    required this.userModel,
  });
}
