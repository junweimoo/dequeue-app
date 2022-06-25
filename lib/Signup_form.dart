import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Customer_screens/Customer_main.dart';
import 'Vendor_screens/Vendor_main.dart';

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
  String dropdownValue = null;
  bool _obscurePassword;

  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
  }

  void _toggleObscure() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _trysubmit() async {
    try {
      if (dropdownValue == null) {
        return;
      }
      final _allEntryValid = _formkey.currentState.validate();
      FocusScope.of(context).unfocus();
      UserCredential _authresult;

      if (_allEntryValid) {
        _formkey.currentState.save();
        _authresult = await _auth.createUserWithEmailAndPassword(
          email: _email.trim(),
          password: _password.trim(),
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_authresult.user.uid)
            .set({
          'email': _email,
          'username': _username,
          'type': dropdownValue,
        });
        final prefs = await SharedPreferences.getInstance();
        String userType = dropdownValue;
        if (userType == "customer") {
          await prefs.setString("userType", "customer");
          Navigator.of(context).pushReplacementNamed('/customer-home');
        } else if (userType == "vendor") {
          await prefs.setString("userType", "vendor");
          Navigator.of(context).pushReplacementNamed('/vendor-home');
        }
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: Text(
            error.toString(),
          ),
        ),
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
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                    onPressed: _toggleObscure,
                    icon: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                    ))
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
            DropdownButtonFormField2(
              hint: Text('Register as'),
              value: dropdownValue,
              items: [
                DropdownMenuItem(
                  child: Text('Customer'),
                  value: 'customer',
                ),
                DropdownMenuItem(
                  child: Text('Vendor'),
                  value: 'vendor',
                ),
              ],
              onChanged: (value) {
                setState(() {
                  dropdownValue = value as String;
                });
              },
              onSaved: (value) {
                setState(() {
                  dropdownValue = value.toString();
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
