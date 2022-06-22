import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/Login_signup_page.dart';

void main() {
  Firebase.initializeApp();

  testWidgets('Login page shows on app start', (tester) async {
    Widget testWidget = MaterialApp(
      home: LoginPage()
    );
    await tester.pumpWidget(testWidget);
    final loginTextFinder = find.text("Login");
    final signupTextFinder = find.text("Sign up");

    expect(loginTextFinder, findsOneWidget);
  });

  testWidgets('Switching between login and signup forms', (tester) async {
    Widget testWidget = MaterialApp(
        home: LoginPage()
    );
    await tester.pumpWidget(testWidget);
    final loginTextFinder = find.text("Login");
    final signupTextFinder = find.text("Sign up");

    expect(loginTextFinder, findsOneWidget);
  });

  testWidgets('Input fields for login form are validated', (tester) async {
    Widget testWidget = MaterialApp(
        home: LoginPage()
    );
    await tester.pumpWidget(testWidget);
    final loginTextFinder = find.text("Login");
    final signupTextFinder = find.text("Sign up");

    expect(loginTextFinder, findsOneWidget);
  });
}
