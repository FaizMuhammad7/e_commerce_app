import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/controllers/admin_controller/product_controllers.dart';
import 'package:e_commerce_app/controllers/admin_controller/upload_image_controller.dart';
import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../custom_widget/my_e_button.dart';
import '../../../custom_widget/my_text_field.dart';
import '../../../helpers/app_colors.dart';
import '../../../models/product_model.dart';

class UploadProductScreen extends StatelessWidget {
  const UploadProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pController = Get.put(ProductController());
    var uploadImageC = Get.put(UploadImageController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Upload Products",
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
                  () {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: pController.imageUrl.value.isEmpty
                      ? null
                      : CachedNetworkImage(
                    imageUrl: pController.imageUrl.value.toString(),
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
            Row(
              children: [
                Expanded(
                  child: MyTextField(
                    controller: pController.pName,
                    keyboardType: TextInputType.text,
                    hintText: "Product Name",
                    hintStyle: TextStyle(
                        color: AppColors.textColor.withOpacity(.8),
                        fontFamily: "Poppins_Regular",
                        fontSize: 12),
                    field: true,
                    fillColor: AppColors.textGreyColor.withOpacity(.2),
                  ).paddingOnly(right: 7),
                ),
                Expanded(
                  child: MyTextField(
                    controller: pController.pPrice,
                    keyboardType: TextInputType.text,
                    hintText: "Product Price",
                    hintStyle: TextStyle(
                        color: AppColors.textColor.withOpacity(.8),
                        fontFamily: "Poppins_Regular",
                        fontSize: 12),
                    field: true,
                    fillColor: AppColors.textGreyColor.withOpacity(.2),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 8, vertical: 8),
            Row(
              children: [
                Expanded(
                  child: MyTextField(
                    controller: pController.cName,
                    keyboardType: TextInputType.text,
                    hintText: "Category Name",
                    hintStyle: TextStyle(
                        color: AppColors.textColor.withOpacity(.8),
                        fontFamily: "Poppins_Regular",
                        fontSize: 12),
                    field: true,
                    fillColor: AppColors.textGreyColor.withOpacity(.2),
                  ).paddingOnly(right: 7),
                ),
                Expanded(
                  child: MyTextField(
                    controller: pController.pQuantity,
                    keyboardType: TextInputType.text,
                    hintText: "Product Quantity",
                    hintStyle: TextStyle(
                        color: AppColors.textColor.withOpacity(.8),
                        fontFamily: "Poppins_Regular",
                        fontSize: 12),
                    field: true,
                    fillColor: AppColors.textGreyColor.withOpacity(.2),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 8, vertical: 8),
            MyTextField(
              controller: pController.pDes,
              keyboardType: TextInputType.text,
              hintText: "Product Description",
              hintStyle: TextStyle(
                  color: AppColors.textColor.withOpacity(.8),
                  fontFamily: "Poppins_Regular",
                  fontSize: 12),
              field: true,
              fillColor: AppColors.textGreyColor.withOpacity(.2),
            ).paddingSymmetric(horizontal: 8, vertical: 10),
            Row(
              children: [
                Expanded(
                  child: MyTextField(
                    controller: pController.pDeliveryT,
                    keyboardType: TextInputType.text,
                    hintText: "Delivery Time",
                    hintStyle: TextStyle(
                        color: AppColors.textColor.withOpacity(.8),
                        fontFamily: "Poppins_Regular",
                        fontSize: 12),
                    field: true,
                    fillColor: AppColors.textGreyColor.withOpacity(.2),
                  ).paddingOnly(
                    right: 5,
                  ),
                ),
                Expanded(
                  child: SizedBox(
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
                          borderRadius: BorderRadius.circular(8)),
                      tileColor: AppColors.textGreyColor.withOpacity(.2),
                      onTap: () async {
                        var result = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (result != null) {
                          var imagePath = result.path;
                          // var id = UniqueKey().toString().
                          // replaceAll('[', "").replaceAll("]", "").
                          // replaceAll("#", "");
                          pController.imageUrl.value =
                              await uploadImageC.uploadImage(
                            StorageConstants.productRef,
                            imagePath,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 8, vertical: 8),
            MyButton(
              Text: Obx(
                () {
                  return pController.isLoading.value == false
                      ? Text(
                          "Upload Product",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins_Regular",
                              fontSize: 14),
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
                EasyLoading.show(status: "Please wait...");
                var productId = UniqueKey()
                    .toString()
                    .replaceAll('[', "")
                    .replaceAll("]", "")
                    .replaceAll("#", "");
        
                var categoryId = UniqueKey()
                    .toString()
                    .replaceAll('[', "")
                    .replaceAll("]", "")
                    .replaceAll("#", "");
        
                var productObj = ProductModel(
                  productId: productId,
                  productName: pController.pName.text,
                  categoryId: categoryId,
                  categoryName: pController.cName.text,
                  productPrice: pController.pPrice.text,
                  productImage: pController.imageUrl.value,
                  productDes: pController.pDes.text,
                  pDeliveryTime: pController.pDeliveryT.text,
                  createAt: DateTime.now().toString(),
                  updateOn: " ",
                  pQuantity: pController.pQuantity.text,
                  isSale: false,
                  isFavorite: false,
                );
                await DbConstants.productsRef.doc(productId).set(
                      productObj.toMap(),
                    );
                EasyLoading.dismiss();
              },
              bgColor: AppColors.textColor,
              buttonSize: Size(280, 44),
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ).paddingOnly(top: 70),
          ],
        ),
      ),
    );
  }
}
