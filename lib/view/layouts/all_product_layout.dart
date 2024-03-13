import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:e_commerce_app/view/layouts/all_user_order_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_item_controller.dart';
import '../../controllers/get_total_user_order.dart';
import '../../controllers/home_controller.dart';
import '../../custom_widget/my_text_field.dart';
import '../../helpers/app_colors.dart';
import '../../models/product_model.dart';
import '../../utils/carousel_slider.dart';
import '../screens/product_screen/add_to_cart_screen.dart';
import '../screens/product_screen/all_category_screen.dart';

class AllProductLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var orderCartController = Get.put(GetTotalUserOrderCart());
    var cartController = Get.put(CartItemController());
    var favorite = false.obs;

    return Scaffold(
      backgroundColor: AppColors.bgAppColor,
      body: FutureBuilder(
        future: DbConstants.productsRef.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: AppColors.textColor,
                  strokeWidth: 3,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text("No Data available"),
            );
          }

          var data = snapshot.data!.docs.map((doc) {
            return ProductModel.fromMap(doc.data());
          }).toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Find Your Favorite",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins_SemiBold",
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Shoe Style",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins_SemiBold",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Obx(() {
                      return IconButton(
                        onPressed: () {
                          Get.to(() => AllUserOrderLayout());
                        },
                        icon: Badge(
                          label: Text(orderCartController.cartOrderLength.value
                              .toString()),
                          child: Icon(Icons.shopping_cart),
                        ),
                      );
                    }),
                  ],
                ).paddingOnly(top: 40),
                MyTextField(
                  onChanged: (value) {
                    controller.setSearchText(value);
                  },
                  hintText: "Enter Your Fashion",
                  hintStyle: TextStyle(
                    color: AppColors.textColor.withOpacity(.8),
                    fontFamily: "Poppins_Regular",
                    fontSize: 12,
                  ),
                  SuffixIcon: Icon(
                    Icons.search_outlined,
                    color: AppColors.textColor.withOpacity(.8),
                  ),
                  field: true,
                  fillColor: AppColors.textGreyColor.withOpacity(.2),
                ).paddingOnly(top: 5),
                CarouselSliderPage(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontFamily: "Poppins_SemiBold",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => AllCategoryScreen());
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontFamily: "Poppins_Regular",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(top: 4, bottom: 4), // CustomTabBar(),
                Obx(() {
                  var filteredData = data
                      .where((product) => product.productName
                          .toLowerCase()
                          .contains(controller.searchText.value.toLowerCase()))
                      .toList();
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: PageScrollPhysics(),
                    itemCount: filteredData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      mainAxisExtent: 230,
                    ),
                    itemBuilder: (context, index) {
                      var docs = filteredData[index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.withOpacity(.7),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => AddToCartScreen(
                                            productModel: docs));
                                      },
                                      child: Image.network(
                                        docs.productImage,
                                        height: 140,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      print(
                                          "Favorite before tap: ${favorite.value}");
                                      await DbConstants.productsRef
                                          .doc(docs.productId)
                                          .update({
                                        "isFavorite": !docs.isFavorite,
                                      });
                                      print(
                                          "Favorite after tap: ${docs.isFavorite}");
                                      favorite.value = !favorite.value;
                                    },
                                    child: CircleAvatar(
                                      child: Obx(() {
                                        return Icon(
                                          favorite.value
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          color: favorite.value
                                              ? Colors.red
                                              : Colors.black,
                                        );
                                      }),
                                      radius: 18,
                                      backgroundColor: AppColors.naturalLight,
                                    ).paddingAll(6),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: Colors.black,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    docs.productName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    docs.pQuantity,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "price",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                          Text(
                                            "\$${docs.productPrice}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          cartController
                                              .checkProductExist(docs);
                                        },
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.blue,
                                            size: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ).paddingOnly(top: 9),
                                ],
                              ).paddingAll(5),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ],
            ).paddingAll(12),
          );
        },
      ),
    );
  }
}
