import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  //const AccountScreen({ Key? key }) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://knowyourcustomer.com/wp-content/uploads/2021/04/blank-profile-picture-973460_640.png'),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Account',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            child: GestureDetector(
              child: InkWell(
                child: Row(
                  children: [
                    const Text(
                      'Edit profile',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    const Icon(Icons.person_pin_rounded),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
                onTap: () {},
              ),
            ),
            height: 60,
            width: double.infinity,
          ),
          Divider(
            height: 0,
            thickness: 1,
          ),
          Container(
            child: GestureDetector(
              child: InkWell(
                child: Row(
                  children: [
                    const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    const Icon(Icons.settings_outlined),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
                onTap: () {},
              ),
            ),
            height: 60,
            width: double.infinity,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
