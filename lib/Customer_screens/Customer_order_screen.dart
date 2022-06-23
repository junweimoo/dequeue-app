import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Customer_order_widget.dart';

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
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Ongoing"),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      left: 5,
                    ),
                  ),
                  Padding(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Completed"),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      left: 5,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data.size,
                  itemBuilder: (ctx, index) {
                    final order = data.docs[index];
                    return Customer_order_widget(order);
                  },
                  shrinkWrap: true,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
