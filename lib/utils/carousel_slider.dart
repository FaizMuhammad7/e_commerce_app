import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarouselSliderPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Obx(() {
      return Column(
        children: [
          CarouselSlider(
            carouselController: controller.carouselController,
            options: CarouselOptions(
              height: 120.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              onPageChanged: (index, reason) {
                controller.CarouselCIndex.value = index;
              },
              viewportFraction: 0.8,
            ),
            items: controller.items.map((item) =>
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(item),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
            ).toList(),
          ).paddingOnly(top: 15,bottom: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: controller.items.asMap().entries.map((entry) {
              int index = entry.key;
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == controller.CarouselCIndex.value ?
                  Colors.brown : Colors.grey,
                ),
              );
            }).toList(),
          ),
        ],
      );
    });
  }
}
