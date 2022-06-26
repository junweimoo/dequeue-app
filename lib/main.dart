// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Customer_screens/Customer_food_detail.dart';
import 'package:first_app/Customer_screens/Customer_order_screen.dart';
import 'package:first_app/Vendor_screens/Vendor_food_detail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './Vendor_screens/Vendor_main.dart';
import './Customer_screens/Customer_main.dart';
import './Login_signup_page.dart';
import 'Customer_screens/food_stalls_screen.dart';
import 'Customer_screens/Customer_menu_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userType = await prefs.getString("userType");
  /* runApp(MultiProvider(
    providers: [],
    child: MyApp(),
  )); */
  runApp(MyApp(userType));
}

class MyApp extends StatelessWidget {
  final String userType;

  const MyApp(this.userType);

  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  Widget getHomePage() {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return userType == "customer" ? CustomerHomePage(0) : VendorHomePage();
    } else {
      return LoginPage();
    }
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
            home: getHomePage(),
            routes: {
              VendorHomePage.routeName: (ctx) => VendorHomePage(),
              CustomerHomePage.routeName: (ctx) => CustomerHomePage(0),
              CustomerHomePage.routeName1: (ctx) => CustomerHomePage(1),
              LoginPage.routeName: (ctx) => LoginPage(),
              FoodStallList.routeName: (ctx) => FoodStallList(),
              CustomerMenuScreen.routeName: (ctx) => CustomerMenuScreen(),
              CustomerFoodDetail.routeName: (ctx) => CustomerFoodDetail(),
              VendorFoodDetail.routeName: (ctx) => VendorFoodDetail(),
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
