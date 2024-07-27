import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  RxBool loginProcess=false.obs;
  RxBool passwordVisible=false.obs;
  Rx<TextEditingController> emailController=TextEditingController().obs;
  Rx<TextEditingController> passwordController=TextEditingController().obs;
}