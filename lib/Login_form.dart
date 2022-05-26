import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  String _email;
  String _password;

  void _trysubmit() async {
    final _allEntryValid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_allEntryValid) {
      _formkey.currentState.save();
      await _auth
          .signInWithEmailAndPassword(
        email: _email.trim(),
        password: _password.trim(),
      )
          .then((value) async {
        if (value == null) {
          //TODO: warn user of errors
        } else {
          DocumentReference documentReference = FirebaseFirestore.instance
              .collection('users')
              .doc(value.user.uid);
          String userType;
          await documentReference.get().then((snapshot) {
            Map<String, dynamic> data = snapshot.data();
            userType = data['type'];
          });
          if (userType == 'customer') {
            //TODO: move to customer screen
          } else {
            Navigator.of(context).popAndPushNamed(VendorHomePage.routeName);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 20,
        ),
        child: Column(
          children: [
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
              validator: (value) {
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: _trysubmit,
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
