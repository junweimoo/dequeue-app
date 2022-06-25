import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './Vendor_screens/Vendor_main.dart';
import './Customer_screens/Customer_main.dart';

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
  bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _trysubmit() async {
    try {
      final _allEntryValid = _formkey.currentState.validate();
      FocusScope.of(context).unfocus();

      if (_allEntryValid) {
        _formkey.currentState.save();
        final user = await _auth.signInWithEmailAndPassword(
          email: _email.trim(),
          password: _password.trim(),
        );
        if (user != null) {
          String userType = await getUserType(user.user.uid);
          final prefs = await SharedPreferences.getInstance();
          if (userType == "customer") {
            await prefs.setString("userType", "customer");
            Navigator.of(context).pushReplacementNamed('/customer-home');
          } else if (userType == "vendor") {
            await prefs.setString("userType", "vendor");
            Navigator.of(context).pushReplacementNamed('/vendor-home');
          }
        }
      }
    } catch (error) {
      if (error.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (ctx) => const AlertDialog(
              content: Text(
                "Wrong password. Please check your password and try again."
              ),
            )
        );
      } else {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              content: Text(
                error.toString(),
              ),
            )
        );
      }
    }
  }

  Future<String> getUserType(userId) async {
    DocumentSnapshot ds =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    Map<String, dynamic> data = ds.data() as Map<String, dynamic>;
    return data["type"];
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
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                    onPressed: _toggleObscure,
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                    ))
              ),
              onSaved: (value) {
                _password = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your password';
                }
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
