import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/custom_widget/my_list_tile.dart';
import 'package:e_commerce_app/helpers/app_colors.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/view/components_screen/update_profile_screen.dart';
import 'package:e_commerce_app/view/layouts/all_user_order_layout.dart';
import 'package:e_commerce_app/view/screens/auth_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/google_sign_controller.dart';
import '../../custom_widget/my_e_button.dart';
import '../../helpers/firebase_helpers.dart';


class ProfileLayout extends StatelessWidget {
  const ProfileLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgAppColor,
      body: FutureBuilder(
        future: DbConstants.usersRef
            .doc(AuthConstants.currentUserId.toString())
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.textColor,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text(
                "No data available",
                style: TextStyle(
                  color: AppColors.textColor,
                  fontFamily: "Poppins_Regular",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            );
          }

          var data = UserModel.fromMap(
              snapshot.data!.data() as Map<String, dynamic>);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Profile",
                style: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: "Poppins_SemiBold",
                    fontSize: 20),
              ).paddingOnly(top: 60),
              Row(
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(100),
                    child: data.imageUrl.isEmpty ?
                      Image.asset(
                      "assets/images/place_holder.jpg",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    )
                      : CachedNetworkImage(
                      imageUrl: data.imageUrl.toString(),
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, downloadProgress) {
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
                  ).paddingOnly(right: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name.toString(),
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontFamily: "Poppins_Regular",
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        data.email,
                        style: TextStyle(
                          color: AppColors.greyColor,
                          fontFamily: "Poppins_Regular",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ).paddingOnly(top: 10),
              MyListTile(
                title: Text(
                  "My Orders",
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: "Poppins_Regular",
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                subtitle: Text(
                  "Already have 12 orders",
                  style: TextStyle(color: AppColors.greyColor, fontSize: 12),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Get.to(()=> AllUserOrderLayout());
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              MyListTile(
                title: Text(
                  "Payment Method",
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: "Poppins_Regular",
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                subtitle: Text(
                  "Visa **02",
                  style: TextStyle(color: AppColors.greyColor, fontSize: 12),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              MyListTile(
                title: Text(
                  "Setting",
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: "Poppins_Regular",
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                subtitle: Text(
                  "Edit Profile, Notifications",
                  style: TextStyle(color: AppColors.greyColor, fontSize: 12),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Get.to(() => UpdateProfileScreen(userModel: data,));
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              MyListTile(
                title: Text(
                  "My Reviews",
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: "Poppins_Regular",
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                subtitle: Text(
                  "Reviews for 4 items",
                  style: TextStyle(color: AppColors.greyColor, fontSize: 12),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              MyListTile(
                title: Text(
                  "Log out",
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: "Poppins_Regular",
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
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
                                            builder: (context) =>
                                                LoginScreen()));
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
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
            ],
          );
        },
      ).paddingAll(12),
    );
  }
}
