import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  var selectedIndex = 0.obs;
  RxString searchText = ''.obs;

  void setSearchText(String text) {
    searchText.value = text;
  }



  /// Carousel slider
  final List items = [
    "assets/images/banners/banner_1.webp",
    "assets/images/banners/banner_2.jpeg",
    "assets/images/banners/banner_3.jpg",
    "assets/images/banners/banner_4.jpg",
    "assets/images/banners/banner_7.jpg",].obs;
  var CarouselCIndex = 0.obs;
  CarouselController carouselController = CarouselController();
}