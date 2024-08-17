import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrendItemPage extends StatefulWidget {
  const TrendItemPage({super.key});

  @override
  State<TrendItemPage> createState() => _TrendItemPageState();
}

class _TrendItemPageState extends State<TrendItemPage> {
  var isBookmarked = false.obs; // Using RxBool for reactive state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity * 0.4,
                child: Image.asset(
                  "assets/4.jpg",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shirt',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'The automobile layout consists of a front-engine design, with transaxle-type transmissions mounted at the rear of the engine and four wheel drive.',
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.09),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Obx(
                            () => IconButton(
                              onPressed: () {
                                isBookmarked.value = !isBookmarked.value;
                              },
                              icon: Icon(
                                isBookmarked.value
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: Colors.black,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          child: ElevatedButton(
                            onPressed: () {
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                            ),
                            child: Text(
                              'Try it',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
