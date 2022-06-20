// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Food_detail_screen.dart';
import './Vendor_screens/Vendor_main.dart';
import './Customer_screens/Customer_main.dart';
import './Login_signup_page.dart';
import 'Customer_screens/food_stalls_screen.dart';
import 'Customer_screens/Customer_menu_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /* runApp(MultiProvider(
    providers: [],
    child: MyApp(),
  )); */
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeFirebase(),
      builder: (context, appSnapshot) {
        if (appSnapshot.hasError) {
          return Text('Something went wrong');
        }
        if (appSnapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Test',
            home: LoginPage(),
            routes: {
              FoodDetailScreen.routeName: (ctx) => FoodDetailScreen(),
              VendorHomePage.routeName: (ctx) => VendorHomePage(),
              CustomerHomePage.routeName: (ctx) => CustomerHomePage(),
              LoginPage.routeName: (ctx) => LoginPage(),
              FoodStallList.routeName: (ctx) => FoodStallList(),
              CustomerMenuScreen.routeName: (ctx) => CustomerMenuScreen(),
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
