import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Menu_Button.dart';
import '../Food.dart';

class VendorMenu extends StatefulWidget {
  //const CanteenList({ Key? key }) : super(key: key);

  @override
  State<VendorMenu> createState() => _VendorMenuState();
}

class _VendorMenuState extends State<VendorMenu> {
  final Stream<QuerySnapshot> food_list =
      FirebaseFirestore.instance.collection('Food_items').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: food_list,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            final data = snapshot.requireData;
            return GridView.builder(
              itemCount: data.size,
              itemBuilder: (ctx, index) {
                return MenuButton(
                  food: Food(
                      name: data.docs[index]['name'],
                      image: data.docs[index]['imageUrl'],
                      price: data.docs[index]['price'].toDouble()),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 2,
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
            );
          }
        });
  }
}
