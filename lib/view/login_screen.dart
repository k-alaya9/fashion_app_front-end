import 'package:fashionapp/controller/loginController.dart';
import 'package:fashionapp/service/Api/TokenStorage.dart';
import 'package:fashionapp/service/Api/authentication_api.dart';
import 'package:fashionapp/view/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> formKey=GlobalKey<FormState>();
  final LoginController controller=Get.put(LoginController());
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent,
            leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios)),
          ),
          extendBody: true,
          body: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.60,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/login.png'),
                            fit: BoxFit.fitWidth
                        ),
                      )),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,

                    height: MediaQuery.of(context).size.height/2,
                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                    decoration:const  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                    ),
                    child: Obx(
                          () => Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Login",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                            const Spacer(),
                            // Text("Email",style: TextStyle(fontSize: 18),),
                            // const Spacer(),
                            buildPhoneFormField(),
                            const Spacer(),
                            // Text("Password",style: TextStyle(fontSize: 18),),
                            // const Spacer(),
                            buildPasswordFormField(),
                            const Spacer(),
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
                                onPressed: controller.loginProcess.value?null:()async{
                                  if(formKey.currentState!.validate()){
                                    controller.loginProcess(true);
                                    await login(controller.emailController.value.text, controller.passwordController.value.text);
                                    if(TokenStorage().getToken()!=null) {
                                      Get.offAll(()=>Home());
                                      controller.loginProcess(false);
                                    }
                                  }
                                  },
                                child: controller.loginProcess.value != true
                                    ? const  Text("Login",
                                    style: TextStyle(color: Colors.white,fontSize: 16))
                                    : const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      controller: controller.emailController.value,
      validator: (value) =>
      value!.isEmpty ? 'this Field is required' : null,
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
        label:const    Text("Email",),
        labelStyle:TextStyle(fontSize: 14,),

      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: !controller
          .passwordVisible.value,
      controller: controller.passwordController.value,
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
        label: const Text("Password"),
        labelStyle:TextStyle(fontSize: 14,),
        // Here is key idea
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            controller.passwordVisible.value
                ? Icons.visibility
                : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            controller.passwordVisible(!controller.passwordVisible.value);
          },
        ),
      ),
    );
  }
}
