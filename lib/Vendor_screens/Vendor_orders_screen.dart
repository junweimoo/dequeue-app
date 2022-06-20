import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Order.dart';
import '../Food.dart';

class OrderQueue extends StatefulWidget {
  //const Queue({ Key? key }) : super(key: key);

  @override
  State<OrderQueue> createState() => _OrderQueueState();
}

class _OrderQueueState extends State<OrderQueue> {
  final Stream<QuerySnapshot> order_list = FirebaseFirestore.instance
      .collection('orders')
      .where("vendorId",
          isEqualTo: FirebaseAuth.instance.currentUser.uid.toString())
      .where("done", isEqualTo: false)
      .orderBy('createdTime', descending: false)
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
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: Container(
                              child: Text(
                                order["foodName"],
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              color: const Color.fromARGB(109, 121, 115, 115),
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Notes: \n${order["notes"]}',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 100,
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              order.reference.update({
                                "done": true,
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'Done',
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.orange,
                        ),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                height: 200,
                width: double.infinity,
              );
            },
            shrinkWrap: true,
          );
        }
      },
    );
  }
}
