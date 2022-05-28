// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Food_detail_screen.dart';
import './Vendor_screens/Vendor_main.dart';
import './Customer_screens/Customer_main.dart';
import './Login_page.dart';

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
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (userSnapshot.hasData) {
                  String userType;
                  //print(userSnapshot.data.uid);
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(userSnapshot.data.uid)
                      .snapshots()
                      .first
                      .then((snapshot) {
                    userType = snapshot.data()['type'];
                    //print(userType);
                  });
                  if (userType == 'customer') {
                    return CustomerHomePage();
                  } else {
                    return VendorHomePage();
                  }
                  /* String userType;
                  documentReference.get().then((snapshot) {
                    Map<String, dynamic> data = snapshot.data();
                    userType = data['type'];
                  });
                  print(userType);
                  if (userType == 'customer') {
                    return CustomerHomePage();
                  } else {
                    return VendorHomePage();
                  } */
                }
                return LoginPage();
              },
            ),
            routes: {
              FoodDetailScreen.routeName: (ctx) => FoodDetailScreen(),
              VendorHomePage.routeName: (ctx) => VendorHomePage(),
              CustomerHomePage.routeName: (ctx) => CustomerHomePage(),
              LoginPage.routeName: (ctx) => LoginPage(),
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
