import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Account_screen.dart';
import './Customer_menu_screen.dart';
import './Customer_order_screen.dart';
import './Customer_canteens_screen.dart';

class CustomerHomePage extends StatefulWidget {
  static const routeName = '/customer-home';
  static const routeName1 = '/customer-home-orders';
  final int _startIndex;

  CustomerHomePage(this._startIndex);

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  int _currIndex;

  @override
  void initState() {
    _currIndex = widget._startIndex;
  }

  static const _TITLE = [
    'Canteens',
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
      CanteenList(),
      CustomerOrderScreen(),
      AccountScreen(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(_TITLE[_currIndex]),
      ),
      body: screens[_currIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currIndex,
        onTap: onTap,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: 'Food',
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
