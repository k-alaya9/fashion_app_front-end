import 'package:fashionapp/controller/registerController.dart';
import 'package:fashionapp/service/Api/authentication_api.dart';
import 'package:fashionapp/view/home.dart';
import 'package:fashionapp/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/Api/TokenStorage.dart';

class Register_Screen extends StatelessWidget {
  final GlobalKey<FormState> formkey=GlobalKey<FormState>();
  final RegisterController controller=Get.put(RegisterController());
   Register_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 21,vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
            ),
            boxShadow: [BoxShadow(offset: Offset(0, -1),blurStyle: BlurStyle.outer,blurRadius: 1)],
          ),
          child: Obx(
            ()=> Form(
              key: formkey,
              child: ListView(
                children: [
                  const SizedBox(height: 10,),
                  const  Text("Register",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 27,),
                  const Text("Email",style: TextStyle(fontSize: 18),),
                  const SizedBox(height: 10,),
                  buildTextFormField(controller:controller.emailController),
                  const SizedBox(height: 27,),
                  const Text("Username",style: TextStyle(fontSize: 18),),
                  const SizedBox(height: 10,),
                  buildTextFormField(controller:controller.usernameController),
                  const SizedBox(height: 27,),
                  const Text("Password",style: TextStyle(fontSize: 18),),
                  const SizedBox(height: 10,),
                  buildPasswordFormField(controller.passwordController, controller.passwordVisibility.value, (){controller.passwordVisibility(!controller.passwordVisibility.value);}),
                  const SizedBox(height: 27,),
                  const Text("Confirm Password",style: TextStyle(fontSize: 18),),
                  const SizedBox(height: 10,),
                  buildTextFormField(controller:controller.confirmPasswordController,see: true),
                  const SizedBox(height: 27,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                      onPressed:  controller.registerProgress.value?null:()async{
                        if(formkey.currentState!.validate()&&controller.confirmPasswordController.text==controller.passwordController.text){
                          await register_endPoint(controller.usernameController.value.text, controller.emailController.value.text, controller.passwordController.value.text);
                          if(TokenStorage().getToken()!=null) {
                            Get.offAll(()=>Home());
                          }
                        }},
                      child: controller.registerProgress.value != true
                          ? const  Text("Register",
                          style: TextStyle(color: Colors.white,fontSize: 16))
                          : const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 27,),
                  TextButton(onPressed: (){Get.to(()=>LoginScreen());}, child: Text("Already have an account? Login",style: TextStyle(fontSize: 16,color:Colors.black),))
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
  TextFormField buildTextFormField({controller,see}){
    return TextFormField(
      obscureText: see!=null?true:false,
      controller: controller,
       validator: (val)=>
        val ==null || val.isEmpty?  "This Field is requried":null,
      decoration:  InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(10),
            borderSide:BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color:Colors.black)
        ),

      ),
    );
  }
  TextFormField buildPasswordFormField(Textcontroller,passVisibility,function){
    return TextFormField(
      obscureText: !passVisibility,
      controller: Textcontroller,
      validator: (value) => value!.isEmpty
          ? 'this Field is required'
          : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(10),
            borderSide:BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color:Colors.black)
        ),
        // Here is key idea
        suffixIcon: IconButton(
          icon: Icon(
            passVisibility
                ? Icons.visibility
                : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed:function,
        ),
      ),
    );
  }
}
