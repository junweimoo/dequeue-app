import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Customer_order_widget.dart';

class CustomerOrderScreen extends StatefulWidget {
  //const CustomerOrderScreen({Key key}) : super(key: key);
  static const routeName = 'customer-orders';

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  final Stream<QuerySnapshot> orderList = FirebaseFirestore.instance
      .collection('orders')
      .where("userId",
          isEqualTo: FirebaseAuth.instance.currentUser.uid.toString())
      .orderBy('createdTime', descending: true)
      .snapshots();

  bool showOngoing = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: orderList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final data = snapshot.requireData;
            List documents = data.docs;
            documents = documents.where((element) {
              return showOngoing ? !element['done'] : element['done'];
            }).toList();
            return Column(
              children: [
                Row(
                  children: [
                    Padding(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showOngoing = true;
                          });
                        },
                        child: const Text("Ongoing"),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                        left: 5,
                      ),
                    ),
                    Padding(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showOngoing = false;
                          });
                        },
                        child: const Text("Completed"),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                        left: 5,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (ctx, index) {
                      final order = documents[index];
                      return Customer_order_widget(order.data());
                    },
                    shrinkWrap: true,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
