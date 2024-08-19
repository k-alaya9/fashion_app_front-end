
import 'package:fashionapp/model/clothesModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/Api/authentication_api.dart';
import 'home.dart';
import 'trendItem.dart';

class SavedItemsPage extends StatefulWidget {
  const SavedItemsPage({super.key});

  @override
  State<SavedItemsPage> createState() => _SavedItemsPageState();
}

class _SavedItemsPageState extends State<SavedItemsPage> {
  List<clothes>trends = [];
  @override
  void initState() {
    super.initState();
    getData();
  }
  getData()async{
    trends.assignAll(await getSavedList());
    setState(() {
    });
  }
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
      body: trends.isEmpty?const Center(child: CircularProgressIndicator(color: Colors.black,),): SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            TrendsSection(trends: trends),
          ],
        ),
      ),
    );
  }
}

class TrendsSection extends StatelessWidget {
  final List<clothes> trends;

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
          image:trend.image_url!,
          title: trend.name!,
          category: trend.description!,
          id: trend.id!,
          saved_id: trend.saved_id!,
        );
      },
    );
  }
}

