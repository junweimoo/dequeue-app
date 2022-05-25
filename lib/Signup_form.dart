import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SignupForm extends StatefulWidget {
  //const SignupForm({ Key? key }) : super(key: key);
  Function toggleLoginSignup;

  SignupForm(this.toggleLoginSignup);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String _email = '';
  String _username = '';
  String _password = '';
  String dropdownValue;

  void _trysubmit() {
    final _allEntryValid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_allEntryValid) {
      _formkey.currentState.save();
      _auth.createUserWithEmailAndPassword(
        email: _email.trim(),
        password: _password.trim(),
      );
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
              key: ValueKey('email'),
              keyboardType: TextInputType.emailAddress,
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
              key: ValueKey('username'),
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a username';
                }
                return null;
              },
              onSaved: (value) {
                _username = value;
              },
            ),
            TextFormField(
              key: ValueKey('password'),
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (value) {
                if (value.isEmpty || value.length < 8) {
                  return 'Please enter a stronger password';
                }
                return null;
              },
              onSaved: (value) {
                _password = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomDropdownButton2(
              hint: 'Register as',
              value: dropdownValue,
              dropdownItems: [
                'Customer',
                'Vendor',
              ],
              onChanged: (value) {
                setState(() {
                  dropdownValue = value;
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: _trysubmit,
              child: const Text('Signup'),
            ),
            TextButton(
              onPressed: widget.toggleLoginSignup,
              child: const Text('Already have an account?'),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}
