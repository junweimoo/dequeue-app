import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

import 'Vendor_screen/Vendor_main.dart';

class LoginForm extends StatefulWidget {
  //const LoginForm({ Key? key }) : super(key: key);
  Function toggleLoginSignup;

  LoginForm(this.toggleLoginSignup);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  var _selectedIndex = 0;
  String _email;
  String _password;

  void _trysubmit() {
    final _allEntryValid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_allEntryValid) {
      _formkey.currentState.save();
      _auth.signInWithEmailAndPassword(
        email: _email.trim(),
        password: _password.trim(),
      );
    }
  }

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
                labelText: 'Email address',
              ),
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              onSaved: (value) {
                _email = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              onSaved: (value) {
                _password = value;
              },
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
              onPressed: widget.toggleLoginSignup,
              child: const Text('Don\'t have an account yet?'),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}
