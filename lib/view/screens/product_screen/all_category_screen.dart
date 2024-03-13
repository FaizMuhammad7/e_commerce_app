import 'package:e_commerce_app/helpers/app_colors.dart';
import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/admin_controller/product_controllers.dart';
import '../../../custom_widget/custom_tabbar.dart';
import 'category_details_screen.dart';



class AllCategoryScreen extends StatelessWidget {
  var controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Categories",
          style: TextStyle(
            color: AppColors.textColor,
            fontFamily: "Poppins_Regular",
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.bgAppColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: AppColors.textColor,
          ),
        ),
      ),
      body: Column(
        children: [
          CustomTabBar(),
          Expanded(
            child: Obx(
              () {
                String selectedCategory = "All";
                if (controller.selectedIndex.value != 0) {
                  selectedCategory =
                      controller.items[controller.selectedIndex.value];
                }

                return FutureBuilder(
                  future: selectedCategory == "All"
                      ? DbConstants.categoriesRef.get()
                      : DbConstants.categoriesRef
                          .where("categoryN", isEqualTo: selectedCategory)
                          .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.textColor,
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          "No Category Available",
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontFamily: "Poppins_Regular",
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    var data = snapshot.data!.docs;
                    return GridView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        mainAxisExtent: 170,
                      ),
                      itemBuilder: (context, index) {
                        var item = data[index];

                        CateGoryModel categoryModel = CateGoryModel(
                          categoryId: item["categoryId"],
                          categoryN: item["categoryN"],
                          createdAt: item["createdAt"],
                          updatedOn: item["updatedOn"],
                          categoryImage: item["categoryImage"],
                        );

                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.withOpacity(.7),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => CategoryDetailsScreen(
                                    cateGoryModel: categoryModel,
                                  ));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                categoryModel.categoryImage,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ).paddingAll(8);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
