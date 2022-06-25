import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Vendor_screens/Vendor_new_food.dart';
import 'package:flutter/material.dart';

import './Vendor_menu_screen.dart';
import './Vendor_orders_screen.dart';
import '../Account_screen.dart';

class VendorHomePage extends StatefulWidget {
  static const routeName = '/vendor-home';

  @override
  State<VendorHomePage> createState() => _VendorHomePageState();
}

class _VendorHomePageState extends State<VendorHomePage> {
  int _currIndex = 0;

  static const _TITLE = [
    'Menu',
    'Orders',
    'Account',
  ];

  void onTap(int i) {
    setState(() {
      _currIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = <Widget>[
      VendorMenu(),
      OrderQueue(),
      AccountScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_TITLE[_currIndex]),
        actions: _currIndex == 0
            ? [
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => NewFoodDialog());
                  },
                  icon: const Icon(Icons.add),
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
