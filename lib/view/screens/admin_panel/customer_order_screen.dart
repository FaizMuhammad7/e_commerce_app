import 'package:e_commerce_app/view/screens/admin_panel/check_user_order_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/app_colors.dart';
import '../../../helpers/firebase_helpers.dart';
import '../../../models/order_model.dart';


class CustomerOrderScreen extends StatelessWidget {
  var docId, customerName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Screen",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Poppins_SemiBold",
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
      body: FutureBuilder(
        future: DbConstants.orderRef.doc(docId)
            .collection("confirmOrders")
            .orderBy("createdAt", descending: true)
            .get(),
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
          var doc = data.map((e) {
            return OrderModel.fromMap(e.data());
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
                      item.productName,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins_SemiBold",
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    subtitle: Text(
                      item.productPrice,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins_SemiBold",
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        item.productImage,
                      ),
                    ),
                    onTap: () {
                      Get.to(()=> CheckUserOrderDetails(
                        id: item.customerId,
                        orderModel: item,
                      ));
                    },
                  ),
                );
              },
            );
          }
          ;
          return SizedBox();
        },
      ),
    );
  }

  CustomerOrderScreen({
    required this.docId,
    required this.customerName,
  });
}
