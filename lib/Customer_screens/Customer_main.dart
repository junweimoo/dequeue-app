import 'package:flutter/material.dart';

import '../Account_screen.dart';

class CustomerHomePage extends StatefulWidget {
  static const routeName = '/customer-home';
  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  int _currIndex = 0;

  static const _TITLE = [
    'Menu',
    'Orders',
    'Account',
  ];

  static List<Widget> screens = <Widget>[
    //CustomerMenu(),
    //OrderQueue(),
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
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: const Text('Add Menu'),
                              content: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Form(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Name'),
                                      ),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Price'),
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Add image'),
                                      ),
                                      const SizedBox(height: 50),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Submit'),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          onPrimary: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                  },
                  icon: const Icon(Icons.add),
                ),
              ]
            : [],
      ),
      body: AccountScreen(),
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
