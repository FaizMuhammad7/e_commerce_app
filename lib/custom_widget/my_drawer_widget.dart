import 'package:e_commerce_app/custom_widget/my_list_tile.dart';
import 'package:e_commerce_app/view/screens/admin_panel/get_all_order_screen.dart';
import 'package:e_commerce_app/view/screens/admin_panel/get_all_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/google_sign_controller.dart';
import '../helpers/app_colors.dart';
import '../view/screens/admin_panel/upload_category_screen.dart';
import '../view/screens/admin_panel/upload_product_screen.dart';
import '../view/screens/auth_screen/login_screen.dart';
import 'my_e_button.dart';

class MyDrawerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      backgroundColor: Colors.red,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                MyListTile(
                  title: Text(
                    'Users',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins_SemiBold",
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  onTap: (){
                    Get.to(()=> GetAllUserScreen());
                  },
                  leading: Icon(
                    Icons.group,
                    color: Colors.white,
                    size: 20,
                  ),
                  bgColor: Colors.transparent,
                ),
                MyListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.monetization_on,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text(
                    'Sales',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins_SemiBold",
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  bgColor: Colors.transparent,
                ),
                MyListTile(
                  bgColor: Colors.transparent,
                  onTap: () {
                    Get.to(() => UploadProductScreen());
                  },
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text(
                    'Products',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins_SemiBold",
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
                MyListTile(
                  bgColor: Colors.transparent,
                  onTap: () { Get.to(() => UploadCategoryScreen());},
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text(
                    'Category',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins_SemiBold",
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
                MyListTile(
                  bgColor: Colors.transparent,
                  onTap: () {
                    Get.to(()=> GetAllOrderScreen());
                  },
                  leading: Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text(
                    'Orders',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins_SemiBold",
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
                MyListTile(
                  bgColor: Colors.transparent,
                  onTap: () {},
                  leading: Icon(
                    Icons.phone,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text(
                    'Contact us',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins_SemiBold",
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          MyListTile(
            bgColor: Colors.transparent,
            onTap: () {},
            leading: Icon(
              Icons.settings,
              color: Colors.white,
              size: 20,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins_SemiBold",
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
          MyListTile(
            bgColor: Colors.transparent,
            onTap: () {
              Get.bottomSheet(
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Are You sure you went to logout?",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: "Poppins_Regular",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                            Text: Text(
                              "NO",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins_Regular"),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            bgColor: AppColors.bgAppColor,
                            buttonSize: Size(120, 44),
                            shapeBorder: StadiumBorder(),
                          ),
                          SizedBox(width: 10),
                          MyButton(
                            Text: Text(
                              "Yes",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins_Regular"),
                            ),
                            onPressed: () {
                              GoogleAuthController().googleSignOut();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            bgColor: AppColors.textColor,
                            buttonSize: Size(120, 44),
                            shapeBorder: StadiumBorder(),
                          ),
                        ],
                      ).paddingOnly(top: 20)
                    ],
                  ).paddingOnly(top: 30),
                ),
              );
            },
            leading: Icon(
              Icons.logout,
              color: Colors.white,
              size: 20,
            ),
            title: Text(
              'Log Out',
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins_SemiBold",
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ).paddingOnly(top: 70,left: 10),
    );
  }
}
