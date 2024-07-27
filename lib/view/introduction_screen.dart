import 'package:fashionapp/controller/introductionController.dart';
import 'package:fashionapp/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/introductionModel.dart';
import '../widgets/OnBoard.dart';

class IntroductionScreen extends StatelessWidget {
   IntroductionScreen({super.key});
  final List<OnBoard> Data = [
    OnBoard(
      image: "assets/page1.png",
      description: "Welcome to our Virtual Try-On App!",
    ),
    OnBoard(
      image: "assets/page2.png",
      description: " See how the latest styles look on YOU before you buy, from anywhere, anytime.",
    ),
    OnBoard(
      image: "assets/page3.png",
      description: " Discover your perfect fit and unleash your inner fashionista with confidence."

    ),
    OnBoard(
      image: "assets/page4.png",
      description: "Let's get started - fashion awaits!",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    IntroductionController controller= Get.put(IntroductionController());
    return SafeArea(
      child: Scaffold(
        body: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.55,
                  child: PageView.builder(
                    onPageChanged: (index) {
                      controller.pageIndex.value = index;
                    },
                    itemCount: Data.length,
                    controller: controller.pageController,
                    itemBuilder: (context, index) => OnBoardContent(
                      description: Data[index].description,
                      image: Data[index].image,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:  const  EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  decoration:  const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                      )
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Welcome",style: TextStyle(fontSize: 32),),
                      const SizedBox(height: 30,),
                      InkWell(
                        onTap: (){
                          Get.to(()=>LoginScreen());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 69,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: const Center(
                            child: Text("GetStarted",style:TextStyle(
                                color:Colors.white,
                                fontSize: 16
                            ),),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      InkWell(
                        onTap: (){
                          // controller.finishIntroGuest();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 69,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black)
                          ),
                          child: const Center(
                            child: Text("Register",style:TextStyle(
                                color:Colors.black,
                                fontSize: 16
                            ),),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                    ],

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
