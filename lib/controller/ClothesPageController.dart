

import 'package:fashionapp/model/clothesModel.dart';
import 'package:get/get.dart';

import '../service/Api/authentication_api.dart';

class ClothespageController extends GetxController{
  RxList<clothes> items=<clothes>[].obs;
  RxInt id=0.obs;
@override
  void onInit() {
    super.onInit();
    // getData();
  }

  getData()async{
    items.assignAll(await getClothesInCategory(id.value));
    items.refresh();
  }
}