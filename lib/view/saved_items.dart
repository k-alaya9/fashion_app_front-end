
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'trendItem.dart';

class SavedItemsPage extends StatefulWidget {
  const SavedItemsPage({super.key});

  @override
  State<SavedItemsPage> createState() => _SavedItemsPageState();
}

class _SavedItemsPageState extends State<SavedItemsPage> {
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
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
          'Saved Items',
          style: TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            TrendsSection(trends: trends),
          ],
        ),
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
  var isBookmarked = false.obs; // Using RxBool for reactive state

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
                      Obx(() => IconButton(
                            onPressed: () {
                              isBookmarked.value = !isBookmarked.value;
                            },
                            icon: Icon(
                              isBookmarked.value
                                  ? Icons.bookmark
                                  : Icons.bookmark_border_outlined,
                            ),
                          )),
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
