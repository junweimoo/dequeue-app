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
          SizedBox(
            height: 50,
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://knowyourcustomer.com/wp-content/uploads/2021/04/blank-profile-picture-973460_640.png'),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Account',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            child: Card(
              child: InkWell(
                child: Row(
                  children: [
                    Text(
                      'Edit profile',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Icon(Icons.person_pin_rounded),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
                onTap: () {},
              ),
            ),
            height: 60,
            width: double.infinity,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Card(
              child: InkWell(
                child: Row(
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Icon(Icons.settings_outlined),
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
