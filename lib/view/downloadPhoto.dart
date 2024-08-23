import 'package:fashionapp/controller/try_virtual_controller.dart';
import 'package:fashionapp/view/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/Api/authentication_api.dart';

class ImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final CameraController controller= Get.find();
    return Scaffold(
      body: Obx(
       ()=>controller.tryVirtualProgress.value? const Center(child: CircularProgressIndicator(color: Colors.black,),):Stack(
          children: [
            Container(
              height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "http://${ip_address}${controller.experiment.value}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Top left icons
            Positioned(
              top: 50,
              left: 20,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black, size: 40),
                    onPressed: () {
                      Get.off(()=>Home());
                    },
                  ),
                ],
              ),
            ),
            // Top right icons
            Positioned(
              top: 50,
              right: 20,
              child: IconButton(
                icon: const Icon(
                  Icons.thumbs_up_down_outlined,
                  color: Colors.black,
                  size: 50,
                ),
                onPressed: () {
                  _showRateUsDialog(context);
                },
              ),
            ),
            // Bottom button
            Positioned(
              bottom: 20,
              left: 10,
              right: 0,
              child: Row(children: [
                SizedBox(
                  height: 65,
                  child: ElevatedButton(
                    onPressed: () {
                       Get.off(()=>Home());
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const  Icon(
                      Icons.refresh,
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 105,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () async{
                      print("Started");
                      print("http://${ip_address}${controller.experiment.value}");
                      await controller.downloadImageToGallery("http://${ip_address}${controller.experiment.value}");
                      print("end");
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.black,
                      // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    ),
                    child: const Text(
                      'Download',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

void _showRateUsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return RateUsDialog();
    },
  );
}

class RateUsDialog extends StatefulWidget {
  @override
  _RateUsDialogState createState() => _RateUsDialogState();
}

class _RateUsDialogState extends State<RateUsDialog> {
  int _rating = 0; // Variable to store selected rating
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      title: const Text(
        'Rate Us',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'How would you rate our app?',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  _rating > index ? Icons.star : Icons.star_border,
                  size: 30,
                  color: _rating > index ? Colors.yellow : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 1; // Update the rating
                  });
                },
              );
            }),
          ),
          const SizedBox(height: 20),
          if (_rating > 0) // Show feedback section only if a rating is given
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Feedback:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 100,
                  child: TextField(
                    controller: _feedbackController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0),
                    ),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle the submission logic here
              print('Rating: $_rating');
              print('Feedback: ${_feedbackController.text}');
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,

              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: const TextStyle(fontSize: 16),
            ),
            child: const Text('Rate'),
          ),
        ],
      ),
    );
  }
}
