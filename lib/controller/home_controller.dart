
import 'package:fashionapp/model/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/categoryModel.dart';
import '../model/clothesModel.dart';
import '../service/Api/authentication_api.dart';
import '../view/home.dart';
import '../view/profile.dart';
import '../view/tryVirtual.dart';

class HomeController extends GetxController {
  final PageController pageController = PageController();
  RxList<clothes> data=<clothes>[].obs;
  Rx<User>? Signeduser=User(null, null).obs;
  RxList<Category>categories=<Category>[].obs;
  @override
  void onInit() {
    super.onInit();
    getProfile();
    getData();
  }
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
  getData()async{
    var data=await getAllClothes();
    this.data.assignAll(data);
    this.data.refresh();
    categories.assignAll(await getAllCategories());
    categories.refresh();
  }

  getProfile()async{
    Signeduser!.value=await getUser();
    Signeduser!.refresh();
  }
}
