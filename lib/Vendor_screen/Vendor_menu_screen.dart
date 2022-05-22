import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Food_menu.dart';
import '../Menu_Button.dart';
import '../Food_menu.dart';
import '../Food.dart';

class VendorMenu extends StatefulWidget {
  //const CanteenList({ Key? key }) : super(key: key);

  @override
  State<VendorMenu> createState() => _VendorMenuState();
}

class _VendorMenuState extends State<VendorMenu> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Food>>(
        stream: readFoodMenu(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong');
          } else {
            return GridView(
              children: snapshot.data
                  .map((food) => MenuButton(
                        text: food.name,
                        image: food.image,
                      ))
                  .toList(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 2,
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
            );
          }
        });
  }

  Stream<List<Food>> readFoodMenu() {
    print(FirebaseFirestore.instance.collection('Food_items'));
    return FirebaseFirestore.instance.collection('Food_items').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Food.fromJson(doc.data())).toList());
  }
}
