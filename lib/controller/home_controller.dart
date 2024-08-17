
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/home.dart';
import '../view/profile.dart';
import '../view/tryVirtual.dart';

class HomeController extends GetxController {
  final PageController pageController = PageController();
  final RxList<Map<String, String>> trends = [
    {'image': 'assets/4.jpg', 'title': 'Shirt', 'category': 'T-shirt'},
    {'image': 'assets/2.jpg', 'title': 'Blouse', 'category': 'Top'},
    {'image': 'assets/3.jpg', 'title': 'Sweater', 'category': 'Winter Wear'},
    {'image': 'assets/3.jpg', 'title': 'Jeans', 'category': 'Pants'},
    {'image': 'assets/1.jpg', 'title': 'Jacket', 'category': 'Outerwear'},
    {'image': 'assets/3.jpg', 'title': 'Shoes', 'category': 'Footwear'},
  ].obs;

  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
    // switch (index) {
    //   case 0:
    //     Get.off(() => HomePage());
    //     break;
    //   case 1:
    //     Get.off(() => TryVirtual());
    //     break;
    //   case 2:
    //     // Get.off(() => ProfilePage());
    //     break;
    // }
  }
}
