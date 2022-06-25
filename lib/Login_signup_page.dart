import 'package:flutter/material.dart';

import 'Login_form.dart';
import 'Signup_form.dart';

class LoginPage extends StatefulWidget {
  //const LoginPage({Key key}) : super(key: key);
  static const routeName = '/login-page';

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _showLoginForm = true;

  void toggleLoginSignup() {
    setState(() {
      _showLoginForm = !_showLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _showLoginForm
                      ? const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                      : const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                  _showLoginForm
                      ? LoginForm(toggleLoginSignup)
                      : SignupForm(toggleLoginSignup),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
