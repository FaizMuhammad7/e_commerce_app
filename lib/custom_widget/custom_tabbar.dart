import 'package:e_commerce_app/helpers/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/admin_controller/product_controllers.dart';

class CustomTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          SizedBox(
            height: 45,
            width: double.infinity,
            child: ListView.builder(
              itemCount: controller.items.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.selectTab(index);
                  },
                  child: Obx(() {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.all(5),
                      height: 25,
                      width: 70,
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == index
                            ? AppColors.textColor
                            : AppColors.textColor.withOpacity(.05),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          controller.items[index],
                          style: TextStyle(
                            color: controller.selectedIndex.value == index
                                ? Colors.white
                                : AppColors.textColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
