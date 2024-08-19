import 'package:fashionapp/model/clothesModel.dart';
import 'package:fashionapp/service/Api/authentication_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrendItemPage extends StatefulWidget {
  int? id;
  String? image_url;
  String? name;
  String? description;
  int? saved_id;
  TrendItemPage({this.id,super.key});

  @override
  State<TrendItemPage> createState() => _TrendItemPageState();
}

class _TrendItemPageState extends State<TrendItemPage> {
  var isBookmarked = false.obs; // Using RxBool for reactive state
@override
  void initState() {
    super.initState();
    getData();
  }
  getData()async{
    clothes cloth=await getClothById(widget.id!);
    widget.name=cloth.name;
    widget.image_url=cloth.image_url;
    widget.description=cloth.description;
    widget.saved_id=cloth.saved_id;
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
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: widget.image_url==null|| widget.name==null || widget.description==null ? const Center(child: CircularProgressIndicator(color: Colors.black,),):    Padding(
        padding: EdgeInsets.all(1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity * 0.4,
                child: Image.network(
                  "${widget.image_url}",
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
                      widget.name!,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.description!,
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
                          child: 
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
                                    : Icons.bookmark_border,
                                color: Colors.black,
                                size: 40,
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
