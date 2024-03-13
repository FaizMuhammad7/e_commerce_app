import 'package:e_commerce_app/helpers/app_colors.dart';
import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/product_model.dart';
import 'add_to_cart_screen.dart';

class CategoryDetailsScreen extends StatelessWidget {
  CateGoryModel cateGoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgAppColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgAppColor,
        title: Text(cateGoryModel.categoryN),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            child: Image.network(
              cateGoryModel.categoryImage,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: DbConstants.productsRef
                  .where("categoryName", isEqualTo: cateGoryModel.categoryN)
                  .get(),
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
                    child: Text("No Category available!"),
                  );
                }

                var data = snapshot.data!.docs.map((e) {
                  return ProductModel.fromMap(e.data());
                }).toList();
                return GridView.builder(
                  shrinkWrap: true,
                  physics: PageScrollPhysics(),
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 230,
                  ),
                  itemBuilder: (context, index) {
                    var docs = data[index];
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
                                      Get.to(() =>
                                          AddToCartScreen(productModel: docs));
                                    },
                                    child: Image.network(
                                      docs.productImage,
                                      height: 140,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  child: Icon(
                                    docs.isFavorite == false
                                        ? Icons.favorite_outline
                                        : Icons.favorite,
                                    color: docs.isFavorite == false
                                        ? Colors.black
                                        : Colors.red,
                                  ),
                                  radius: 18,
                                  backgroundColor: AppColors.naturalLight,
                                ).paddingAll(6),
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
                                    CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.blue,
                                        size: 12,
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
                ).paddingAll(10);
              },
            ),
          ),
        ],
      ),
    );
  }

  CategoryDetailsScreen({
    required this.cateGoryModel,
  });
}
