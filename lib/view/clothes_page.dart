import 'package:fashionapp/controller/ClothesPageController.dart';
import 'package:fashionapp/view/saved_items.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClothesPage extends StatelessWidget {
  String name;
  int id;
   ClothesPage({required this.name,required this.id, super.key});
   final ClothespageController controller= Get.find();
   

  @override
  Widget build(BuildContext context) {
    controller.getData();
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body:Obx(() =>  controller.items.isEmpty?const Center(child: CircularProgressIndicator(color: Colors.black,),): SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            TrendsSection(trends: controller.items),
          ],
        ),
      ),)
    );
  }
}