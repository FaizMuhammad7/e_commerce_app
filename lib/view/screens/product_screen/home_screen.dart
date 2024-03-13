import 'package:e_commerce_app/controllers/home_controller.dart';
import 'package:e_commerce_app/helpers/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../layouts/all_product_layout.dart';
import '../../layouts/favorite_layout.dart';
import '../../layouts/profile_layout.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: AppColors.bgAppColor,
      body: Obx(
        () {
          return IndexedStack(
            index: controller.selectedIndex.value,
            children: [
              AllProductLayout(),
              FavoriteLayout(),
              ProfileLayout(),
            ],
          );
        },
      ),
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            backgroundColor: AppColors.bgAppColor,
            currentIndex: controller.selectedIndex.value,
            onTap: (value) {
              controller.selectedIndex.value = value;
            },
            unselectedItemColor: AppColors.greyColor,
            selectedItemColor: Colors.brown,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                label: "Category",
                icon: controller.selectedIndex.value == 0
                    ? Icon(Icons.home)
                    : Icon(Icons.home_outlined),
              ),
              BottomNavigationBarItem(
                label: "Favorite",
                icon: controller.selectedIndex.value == 1
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_outline),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: controller.selectedIndex.value == 2
                    ? Icon(Icons.person)
                    : Icon(Icons.person_outline_outlined),
              ),
            ],
          );
        },
      ),
    );
  }
}
