import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './food_stalls_screen.dart';

class CanteenList extends StatefulWidget {
  //const CanteenList({ Key? key }) : super(key: key);

  @override
  State<CanteenList> createState() => _CanteenListState();
}

class _CanteenListState extends State<CanteenList> {
  final Stream<QuerySnapshot> canteen_list =
      FirebaseFirestore.instance.collection('canteens').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: canteen_list,
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
              return Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      FoodStallList.routeName,
                      arguments: [data.docs[index].id],
                    );
                  },
                  child: Text(
                    data.docs[index]['name'],
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                margin: EdgeInsets.all(8),
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
