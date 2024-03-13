import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/controllers/admin_controller/upload_image_controller.dart';
import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/admin_controller/product_controllers.dart';
import '../../../custom_widget/my_e_button.dart';
import '../../../custom_widget/my_text_field.dart';
import '../../../helpers/app_colors.dart';

class UploadCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var categoryController = Get.put(ProductController());
    var uploadImageC = Get.put(UploadImageController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Upload Category",
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins_SemiBold",
            fontSize: 16,
          ),
        ),
        backgroundColor: AppColors.bgAppColor,
      ),
      backgroundColor: AppColors.bgAppColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: categoryController.imageUrl.value.isEmpty
                    ? null
                    : CachedNetworkImage(
                        imageUrl: categoryController.imageUrl.value.toString(),
                        height: 200,
                        width: 280,
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
              );
            },
          ),
          SizedBox(height: 50),
          MyTextField(
            controller: categoryController.cName,
            keyboardType: TextInputType.text,
            hintText: "Product Name",
            hintStyle: TextStyle(
                color: AppColors.textColor.withOpacity(.8),
                fontFamily: "Poppins_Regular",
                fontSize: 12),
            field: true,
            fillColor: AppColors.textGreyColor.withOpacity(.2),
          ),
          SizedBox(height: 50),
          SizedBox(
            height: 50,
            child: ListTile(
              title: Text(
                "Pic Image",
                style: TextStyle(
                    color: AppColors.textColor.withOpacity(.8),
                    fontFamily: "Poppins_Regular",
                    fontSize: 12),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              tileColor: AppColors.textGreyColor.withOpacity(.2),
              onTap: () async {
                var result =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (result != null) {
                  var imagePath = result.path;
                  categoryController.imageUrl.value =
                      await uploadImageC.uploadImage(
                    StorageConstants.categoryRef,
                    imagePath,
                  );
                }
              },
            ),
          ),
          MyButton(
            Text: Obx(
              () {
                return categoryController.isLoading.value == false
                    ? Text(
                        "Upload Category",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins_Regular",
                          fontSize: 14,
                        ),
                      )
                    : SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.bgAppColor,
                          strokeWidth: 3,
                        ),
                      );
              },
            ),
            onPressed: () async {
              var categoryId = UniqueKey()
                  .toString()
                  .replaceAll('[', "")
                  .replaceAll("]", "")
                  .replaceAll("#", "");

              var time = DateTime.now();
              var categoryObj = CateGoryModel(
                categoryId: categoryId,
                categoryN: categoryController.cName.text,
                createdAt: time.toString(),
                updatedOn: time.toString(),
                categoryImage: categoryController.imageUrl.value,
              );

              await DbConstants.categoriesRef.doc(categoryId).set(
                    categoryObj.toMap(),
                  );
            },
            bgColor: AppColors.textColor,
            buttonSize: Size(280, 44),
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ).paddingOnly(top: 70),
        ],
      ).paddingAll(10),
    );
  }
}
