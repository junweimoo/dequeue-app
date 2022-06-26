import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Vendor_menu_button.dart';
import '../Food.dart';

class VendorMenu extends StatefulWidget {
  //const CanteenList({ Key? key }) : super(key: key);

  @override
  State<VendorMenu> createState() => _VendorMenuState();
}

class _VendorMenuState extends State<VendorMenu> {
  final Stream<QuerySnapshot> food_list = FirebaseFirestore.instance
      .collection('Food_items')
      .where("vendorId",
          isEqualTo: FirebaseAuth.instance.currentUser.uid.toString())
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: food_list,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('something went wrong');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final data = snapshot.requireData;
          return GridView.builder(
            itemCount: data.size,
            itemBuilder: (ctx, index) {
              return MenuButton(
                food: Food(
                  name: data.docs[index]['name'],
                  image: data.docs[index]['imageUrl'],
                  price: data.docs[index]['price'].toDouble(),
                ),
                foodId: data.docs[index].id.toString(),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 2,
              crossAxisCount: 2,
            ),
            shrinkWrap: true,
          );
        }
      },
    );
  }
}
