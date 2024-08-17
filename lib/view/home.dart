
import 'package:fashionapp/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controller/home_controller.dart';
import 'trendItem.dart';
import 'tryVirtual.dart';

class Home extends StatelessWidget{
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Obx(
        ()=> IndexedStack(
          index:controller.selectedIndex.value,
          children: [
            HomePage(),
            TryVirtual(),
            ProfilePage(),
          ],
        ),
      ),
      floatingActionButton: CustomBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

}
class HomePage extends StatelessWidget {
final HomeController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 35,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome back, Khaled',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 50,
                      // margin: EdgeInsets.only(left: 75),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white54,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0.8,
                            blurRadius: 4,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                          child: Center(
                            child: Text(
                              "K",
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                      // child: ClipRRect(
                      //   borderRadius: BorderRadius.circular(10),
                      //   child: Padding(
                      //     padding: EdgeInsets.all(10.0),
                      //     child: Center(
                      //       child: Text(
                      //         "K",
                      //         style: TextStyle(
                      //           fontSize: 27,
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 200,
                    child: PageView(
                      controller: controller.pageController,
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(9.1),
                            child:
                                Image.asset('assets/1.jpg', fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(9.1),
                            child:
                                Image.asset('assets/2.jpg', fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(9.1),
                            child:
                                Image.asset('assets/3.jpg', fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    height: 360,
                    child: Container(
                      margin: EdgeInsets.all(170),
                      child: SmoothPageIndicator(
                        controller: controller.pageController,
                        count: 3,
                        effect: WormEffect(
                          dotWidth: 10.0,
                          dotHeight: 10.0,
                          spacing: 16.0,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),

              // Categories Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Categories',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryItem(title: 'T-Shirt', image: "assets/tshirt.png"),
                    CategoryItem(title: 'Blouse', image: 'assets/blouse.png'),
                    CategoryItem(title: 'Sweater', image: 'assets/sweater.png'),
                    CategoryItem(title: 'Kimono', image: 'assets/judo.png'),
                    CategoryItem(title: 'Skirt', image: 'assets/skirt.png'),
                    CategoryItem(title: 'Dress', image: 'assets/dress.png'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Trends Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  margin: EdgeInsets.only(top: 2),
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Trends',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TrendsSection(),
            ],
          ),
        ),
      ),

    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String image;

  const CategoryItem({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 80,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 50, child: Image.asset(image, fit: BoxFit.fill)),
            SizedBox(height: 7),
            Text(title,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class TrendsSection extends StatelessWidget {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: controller.trends.length,
        itemBuilder: (context, index) {
          final trend = controller.trends[index];
          return TrendItem(
            image: trend['image']!,
            title: trend['title']!,
            category: trend['category']!,
          );
        },
      );
    });
  }
}

class TrendItem extends StatefulWidget {
  final String image;
  final String title;
  final String category;

  TrendItem({
    required this.image,
    required this.title,
    required this.category,
  });

  @override
  _TrendItemState createState() => _TrendItemState();
}

class _TrendItemState extends State<TrendItem> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => TrendItemPage());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isBookmarked = !isBookmarked;
                          });
                        },
                        icon: Icon(
                          isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_border_outlined,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text('Category: ${widget.category}',
                      style: TextStyle(
                          color: Color.fromARGB(255, 115, 115, 115),
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  
  final HomeController controller =Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Bottom Navigation Bar Background
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
            ),
          ),
          // Navigation Icons
          Positioned(
            bottom: 15,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => _buildNavItem(
                      icon: Icons.home,
                      label: 'Home',
                      index: 0,
                      isSelected: controller.selectedIndex.value == 0,
                      onTap: () => controller.onItemTapped(0),
                    )),
                // SizedBox(width: 1), // Spacer for the FAB
                Obx(() => _buildNavItem(
                      icon: Icons.add_circle_outline,
                      label: 'Add',
                      index: 1,
                      isSelected: controller.selectedIndex.value == 1,
                      onTap: () => controller.onItemTapped(1),
                    )),
                Obx(() => _buildNavItem(
                      icon: Icons.account_circle,
                      label: 'Profile',
                      index: 2,
                      isSelected: controller.selectedIndex.value == 2,
                      onTap: () => controller.onItemTapped(2),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color:
          // isSelected ? Colors.black26.withOpacity(0.1) :  Colors.transparent,
          Colors.transparent,
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color:! isSelected ? Colors.black26 : Colors.black,
              size: 30,
            ),
            Text(
              label,
              style: TextStyle(
                color: !isSelected ? Colors.black26 : Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
