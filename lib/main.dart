// ignore_for_file: prefer_const_constructors

import 'package:first_app/DUMMY_FOOD.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Vendor_screen/Vendor_menu_screen.dart';
import 'Vendor_screen/Vendor_orders_screen.dart';
import './Account_screen.dart';
import 'Vendor_screen/Vendor_food_detail_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: ((context) => FoodMenu()))],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      home: MyHomePage(),
      routes: {
        FoodDetailScreen.routeName: (ctx) => FoodDetailScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currIndex = 0;

  static const _TITLE = [
    'Menu',
    'Orders',
    'Account',
  ];

  static List<Widget> screens = <Widget>[
    VendorMenu(),
    OrderQueue(),
    AccountScreen(),
  ];

  void onTap(int i) {
    setState(() {
      _currIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_TITLE[_currIndex]),
        actions: _currIndex == 0
            ? [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                ),
              ]
            : [],
      ),
      body: screens[_currIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currIndex,
        onTap: onTap,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline_outlined),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
