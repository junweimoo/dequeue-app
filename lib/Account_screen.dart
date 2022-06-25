import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/Login_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './Login_signup_page.dart';

class AccountScreen extends StatefulWidget {
  //const AccountScreen({ Key? key }) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Map<String, dynamic> currUserInfo;
  bool isLoading;

  void _getInfo() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((snapshot) {
      setState(() {
        currUserInfo = snapshot.data();
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    isLoading = true;
    _getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://knowyourcustomer.com/wp-content/uploads/2021/04/blank-profile-picture-973460_640.png',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                currUserInfo['username'],
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                child: GestureDetector(
                  child: InkWell(
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 70,
                        ),
                        Text(
                          'Edit profile',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.person_pin_rounded,
                        ),
                        SizedBox(
                          width: 70,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                height: 60,
                width: double.infinity,
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              SizedBox(
                child: GestureDetector(
                  child: InkWell(
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 70,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.settings_outlined,
                        ),
                        SizedBox(
                          width: 70,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                height: 60,
                width: double.infinity,
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              SizedBox(
                child: GestureDetector(
                  child: InkWell(
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 70,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.logout_sharp,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 70,
                        ),
                      ],
                    ),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context)
                          .pushReplacementNamed(LoginPage.routeName);
                    },
                  ),
                ),
                height: 60,
                width: double.infinity,
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
          );
  }
}
