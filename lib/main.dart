import 'package:fashionapp/service/Api/TokenStorage.dart';
import 'package:fashionapp/view/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
        theme:
        ThemeData(primarySwatch: Colors.blue, fontFamily: 'SignikaNegative'),

        // Light theme
        darkTheme: ThemeData.dark(), // Dark theme
        themeMode: ThemeMode.light,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      //   useMaterial3: true,
      // ),
      defaultTransition: Transition.cupertino,
      home: TokenStorage().getToken()!=null?Home():IntroductionScreen()
    );
  }
}
