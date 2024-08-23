
import 'package:fashionapp/controller/ClothesPageController.dart';
import 'package:fashionapp/view/clothes_page.dart';
import 'package:fashionapp/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controller/home_controller.dart';
import '../service/Api/authentication_api.dart';
import 'settings/setting.dart';
import 'trendItem.dart';
import 'tryVirtual.dart';

class Home extends StatelessWidget{
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Obx(
        ()=> controller.Signeduser!.value.username==null?  const  Center(child: CircularProgressIndicator(color: Colors.black,),): IndexedStack(
          index:controller.selectedIndex.value,
          children: [
            HomePage(),
            TryVirtual(),
            const ProfilePage(),
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
                margin: const EdgeInsets.only(top: 35,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Welcome back, ${controller.Signeduser!.value.username}',
                      style:  const  TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: (){Get.to(()=>SettingsPage());},
                      child: Container(
                        width: 50,
                        // margin: EdgeInsets.only(left: 75),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white54,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0.8,
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                            child:  Center(
                              child: Text(
                                controller.Signeduser!.value.username!.characters.first,
                                style: const TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                      ),
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
                          margin: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(2),
                          margin: const EdgeInsets.all(8),
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
                          padding: const EdgeInsets.all(2),
                          margin: const EdgeInsets.all(8),
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
                      margin: const EdgeInsets.all(170),
                      child: SmoothPageIndicator(
                        controller: controller.pageController,
                        count: 3,
                        effect: const WormEffect(
                          dotWidth: 10.0,
                          dotHeight: 10.0,
                          spacing: 16.0,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),

              // Categories Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  alignment: AlignmentDirectional.topStart,
                  child: const Text(
                    'Categories',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: Obx(
                  ()=>controller.categories.isEmpty?const Center(child: CircularProgressIndicator(color: Colors.black,),): ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      var category=controller.categories[index];
                      return CategoryItem(id:category.id!,title:category.name! ,image: category.image_url!,);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Trends Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  margin: const EdgeInsets.only(top: 2),
                  alignment: AlignmentDirectional.topStart,
                  child: const Text(
                    'Trends',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TrendsSection(),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),

    );
  }
}

class CategoryItem extends StatelessWidget {
  final int id;
  final String title;
  final String image;

  const CategoryItem({required this.id,required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(id);
    ClothespageController controller= Get.put(ClothespageController());
        controller.id.value=id;
        print(controller.id.value);
        Get.to(()=>ClothesPage(name: title, id: id));
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.grey[100],
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.1),
          //     spreadRadius: 1,
          //     blurRadius: 5,
          //     offset: const Offset(-3, -3),
          //   ),
          // ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 50, child: Image.network(image, fit: BoxFit.fill)),
            const SizedBox(height: 7),
            Text(title,
                style: const TextStyle(
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
    return Obx(() => controller.data.value.isEmpty? const Center(child: CircularProgressIndicator(color: Colors.black,),):
       GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: controller.data.length,
        itemBuilder: (context, index) {
          final trend = controller.data[index];
          print(trend);
          return TrendItem(
            id: trend.id!,
            image: trend.image_url!,
            title: trend.name!,
            category: trend.description!,
            saved_id: trend.saved_id!,
          );
        },
      ));
  }
}

class TrendItem extends StatefulWidget {
  final int id;
  final String image;
  final String title;
  final String category;
  int saved_id;
  TrendItem({
    required this.id,
    required this.image,
    required this.title,
    required this.category,
    required this.saved_id
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
        Get.to(() => TrendItemPage(id: widget.id,));
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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.network(
                  "${widget.image}",
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
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      IconButton(
                         onPressed: () async{
                                // isBookmarked.value = !isBookmarked.value;
                                if(widget.saved_id==0){
                                widget.saved_id=await saveClothItem(widget.id!);
                                }
                                else{
                                  await unsaveClothItem(widget.id!);
                                  widget.saved_id=0;
                                }
                                setState(() {
                                  
                                });
                              },
                        icon: Icon(
                          widget.saved_id!=0
                              ? Icons.bookmark
                              : Icons.bookmark_border_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Category: ${widget.category}',
                      style: const TextStyle(
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
      margin: const EdgeInsets.all(20),
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
                    offset: const Offset(0, -2),
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
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
