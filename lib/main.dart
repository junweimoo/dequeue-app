// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './Vendor_screen/Vendor_food_detail_screen.dart';
import './Vendor_screen/Vendor_main.dart';
import './Login_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /* runApp(MultiProvider(
    providers: [],
    child: MyApp(),
  )); */
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      home: LoginPage(),
      routes: {
        FoodDetailScreen.routeName: (ctx) => FoodDetailScreen(),
        VendorHomePage.routeName: (ctx) => VendorHomePage(),
      },
    );
  }
}
