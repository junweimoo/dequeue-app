import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

import 'Vendor_screen/Vendor_main.dart';
import 'Login_page.dart';

class LoginForm extends StatefulWidget {
  //const LoginForm({ Key? key }) : super(key: key);
  Function callback;

  LoginForm(this.callback);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 20,
        ),
        child: Column(
          children: [
            FlutterToggleTab(
                width: 40,
                height: 20,
                labels: const [
                  "Customer",
                  "Vendor",
                ],
                selectedLabelIndex: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    //fontSize: 18,
                    fontWeight: FontWeight.w700),
                unSelectedTextStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                selectedIndex: _selectedIndex),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                if (_selectedIndex == 1) {
                  Navigator.of(context).popAndPushNamed(
                    VendorHomePage.routeName,
                  );
                } else {
                  //add customer home screen
                }
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                widget.callback();
              },
              child: const Text('Don\'t have an account yet?'),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}
