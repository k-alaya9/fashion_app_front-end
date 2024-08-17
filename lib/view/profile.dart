import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.dart';
import 'saved_items.dart';
import 'settings/setting.dart';
import 'trendItem.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Map<String, String>> trends = [
    {'image': 'assets/4.jpg', 'title': 'Shirt', 'category': 'T-shirt'},
    {'image': 'assets/2.jpg', 'title': 'Blouse', 'category': 'Top'},
    {'image': 'assets/3.jpg', 'title': 'Sweater', 'category': 'Winter Wear'},
    {'image': 'assets/3.jpg', 'title': 'Jeans', 'category': 'Pants'},
    {'image': 'assets/1.jpg', 'title': 'Jacket', 'category': 'Outerwear'},
    {'image': 'assets/3.jpg', 'title': 'Shoes', 'category': 'Footwear'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(SavedItemsPage());
          },
          icon: Icon(
            Icons.bookmark,
            color: Colors.black,
            size: 40,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(SettingsPage());
            },
            icon: Icon(
              Icons.settings,
              color: Colors.black,
              size: 40,
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          'Profile ',
          style: TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'History',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 27,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 10),
          TrendsSection(trends: trends),
        ]),
      ),
    );
  }
}

class TrendsSection extends StatelessWidget {
  final List<Map<String, String>> trends;

  TrendsSection({required this.trends});

  @override
  Widget build(BuildContext context) {
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
      itemCount: trends.length,
      itemBuilder: (context, index) {
        final trend = trends[index];
        return TrendItem(
          image: trend['image']!,
          title: trend['title']!,
          category: trend['category']!,
        );
      },
    );
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
        Get.to(TrendItemPage());
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
