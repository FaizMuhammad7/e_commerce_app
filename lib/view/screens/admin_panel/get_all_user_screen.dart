import 'package:e_commerce_app/controllers/admin_controller/get_all_user_controller.dart';
import 'package:e_commerce_app/helpers/app_colors.dart';
import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetAllUserScreen extends StatelessWidget {
  const GetAllUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(GetAllUserController());
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(
            "Users ${controller.userLength.value.toString()}",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Poppins_SemiBold",
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          );
        }),
        backgroundColor: AppColors.bgAppColor,
      ),
      backgroundColor: AppColors.bgAppColor,
      body: FutureBuilder(
        future: DbConstants.usersRef.where("isAdmin",isEqualTo: false).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: Colors.brown,
                  strokeWidth: 3,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text(
                " Error no user found!",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins_SemiBold",
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                " Error occur where fetching user!",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins_SemiBold",
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            );
          }

          var data = snapshot.data!.docs;

          /// convert queryDocumentSnapshot into userModel list
          var doc = data.map((e) {
            return UserModel.fromMap(e.data());
          }).toList();

          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: doc.length,
              itemBuilder: (context, index) {
                var item = doc[index];
                return Card(
                  shape: RoundedRectangleBorder(),
                  color: AppColors.bgAppColor,
                  child: ListTile(
                    title: Text(
                      item.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins_SemiBold",
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    subtitle: Text(
                      item.email,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins_SemiBold",
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: item.imageUrl.isEmpty ? null : NetworkImage(item.imageUrl),
                    ),
                  ),
                );
              },
            );
          };
          return SizedBox();
        },
      ),
    );
  }
}
