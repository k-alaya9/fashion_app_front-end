import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{
  TextEditingController emailController=TextEditingController();
  TextEditingController usernameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  RxBool passwordVisibility=false.obs;
  RxBool registerProgress=false.obs;
}