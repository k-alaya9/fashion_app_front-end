import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroductionController extends GetxController{
  // Variables
  late PageController pageController;
  RxInt pageIndex = 0.obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
     timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (pageIndex < 3) {
        pageIndex++;
      } else {
        pageIndex.value = 0;
      }
      pageController.animateToPage(
        pageIndex.value,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void onClose() {
    super.onClose();
    timer!.cancel();
    pageController.dispose();
  }
}