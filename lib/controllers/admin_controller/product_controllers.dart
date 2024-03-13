import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  var isLoading = false.obs;
  var imageUrl = "".obs;
  var pName = TextEditingController();
  var cName = TextEditingController();
  var pPrice = TextEditingController();
  var pQuantity = TextEditingController();
  var pDes = TextEditingController();
  var pDeliveryT = TextEditingController();


  var categoryController = TextEditingController();
  RxInt selectedIndex = 0.obs;
  RxBool isChecked = false.obs;

  void selectTab(int index) {
    selectedIndex.value = index;
  }
  List<String> items = [
    "All",
    "Shirts",
    "Shoes",
    "Tawal",
    "Cloths",
    "Laptop",
    "Bags",
  ];

}