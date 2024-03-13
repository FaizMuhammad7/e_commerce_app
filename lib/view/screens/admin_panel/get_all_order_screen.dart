import 'package:e_commerce_app/helpers/app_colors.dart';
import 'package:e_commerce_app/view/screens/admin_panel/customer_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/firebase_helpers.dart';


class GetAllOrderScreen extends StatelessWidget {
  const GetAllOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Orders",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Poppins_SemiBold",
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
        backgroundColor: AppColors.bgAppColor,
      ),
      backgroundColor: AppColors.bgAppColor,
      body: FutureBuilder(
        future:
        DbConstants.orderRef.orderBy("createdAt", descending: true).get(),
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
                " Error no orders found!",
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
                " Error occur where fetching orders!",
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

          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var item = data[index];
                return Card(
                  shape: RoundedRectangleBorder(),
                  color: AppColors.bgAppColor,
                  child: ListTile(
                    title: Text(
                      item["customerName"],
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins_SemiBold",
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    subtitle: Text(
                      item["customerPhone"],
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins_SemiBold",
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      child: Text(item["customerName"][0].toString()),
                    ),
                    onTap: (){
                      Get.to(()=> CustomerOrderScreen(
                        customerName: item["customerName"],
                        docId: item["user_id"],
                      ));
                    },
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
