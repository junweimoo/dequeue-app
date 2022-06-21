import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerOrderScreen extends StatefulWidget {
  //const CustomerOrderScreen({Key key}) : super(key: key);

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  final Stream<QuerySnapshot> order_list = FirebaseFirestore.instance
      .collection('orders')
      .where("userId",
          isEqualTo: FirebaseAuth.instance.currentUser.uid.toString())
      .orderBy('createdTime', descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: order_list,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('something went wrong');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final data = snapshot.requireData;
          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (ctx, index) {
              final order = data.docs[index];
              return Container(
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        child: Text(
                          "${order["foodName"]}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: const Color.fromARGB(173, 255, 255, 255),
                ),
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 10,
                  top: 15,
                  right: 10,
                ),
              );
            },
            shrinkWrap: true,
          );
        }
      },
    );
  }
}
