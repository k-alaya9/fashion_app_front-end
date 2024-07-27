import 'package:flutter/material.dart';

class OnBoardContent extends StatelessWidget {

  OnBoardContent({super.key,
    required this.image,
    required this.description,
  });

  String image;
  String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(image,height: 336,fit: BoxFit.fitHeight,),
        const Spacer(),
        Text(
          description,
          textAlign: TextAlign.center,
          style:const TextStyle(fontSize: 20)
        ),
      ],
    );
  }
}