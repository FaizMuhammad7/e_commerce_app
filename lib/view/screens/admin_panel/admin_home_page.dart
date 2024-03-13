import 'package:e_commerce_app/helpers/app_colors.dart';
import 'package:e_commerce_app/helpers/firebase_helpers.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:flutter/material.dart';

import '../../../custom_widget/my_drawer_widget.dart';



class AdminHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DbConstants.usersRef.where("isAdmin", isEqualTo: true).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: 30,
              width: 30,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.textColor,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Text(
              "No Data Available",
              style: TextStyle(
                color: AppColors.textColor,
                fontFamily: "Poppins_Regular",
                fontSize: 16,
              ),
            );
          }

          var data = snapshot.data!.docs;
          var doc = data.map((e){
            return UserModel.fromMap(e.data());
          }).toList();

          return ListView.builder(
            shrinkWrap: true,
            itemCount: doc.length,
            itemBuilder: (context, index) {
              var item = doc[index];
              return ListTile(
                title: Text(item.name,style: TextStyle(color: Colors.black),),
              );
            },
          );
        },
      ),
      backgroundColor: AppColors.bgAppColor,
      drawer: MyDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text( "Admin Panel",
          style: TextStyle(color: Colors.white, fontFamily: "Poppins_Semi_Bold"),
        ),
        centerTitle: true,
      ),
    );
  }
}
