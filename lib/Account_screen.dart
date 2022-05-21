import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  //const AccountScreen({ Key? key }) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Center(
            child: Text('Account'),
          ),
          height: 200,
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
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
