
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as Math;

import '../controller/try_virtual_controller.dart';
import 'home.dart';
import 'tryVirtual2.dart';

class TryVirtual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CameraController cameraController = Get.put(CameraController());

    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     Transform.rotate(angle: Math.pi,child: IconButton(onPressed: (){Get.to(()=>TryVirtual2());}, icon: Icon(Icons.arrow_back_ios)))
      //   ],
      // ),
      body: Stack(
        children: [
          // Background image
          Obx(
          ()=> Container(
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: cameraController.selectedImage.value!=null ? FileImage(cameraController.selectedImage.value!):AssetImage(
                      'assets/excited-well-dressed-young-woman-posing-light-wall-attractive-brunette-girl-pink-fur-coat-playing-with-her-hair-laughing.jpg'), // Add your image asset here
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: Transform.rotate(angle:  Math.pi,child: IconButton(onPressed: (){
              if(cameraController.selectedImage.value!=null) {
                Get.to(()=>TryVirtual2());
              }}, icon: Icon(Icons.arrow_back_ios,color: Colors.black, size: 40)))
          ),
          // Try Virtual text
          const Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Try Virtual',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          // Bottom buttons
          Positioned(
            bottom: 140,
            left: 20,
            right: 0,
            child: Row(
              children: [
                SizedBox(
                  height: 65,
                  child: ElevatedButton(
                    onPressed: () {
                      cameraController.pickImageFromCamera(cameraController.selectedImage);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: MediaQuery.of(context).size.width*0.65,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      cameraController.pickImageFromGallery(cameraController.selectedImage);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.black,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    ),
                    child: const Text(
                      'Upload',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     width: 90,
          //     height: 40,
          //     child: CustomBottomNavBar(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
