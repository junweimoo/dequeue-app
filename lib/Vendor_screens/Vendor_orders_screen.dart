import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Order.dart';
import '../Food.dart';

class OrderQueue extends StatefulWidget {
  //const Queue({ Key? key }) : super(key: key);

  @override
  State<OrderQueue> createState() => _OrderQueueState();
}

class _OrderQueueState extends State<OrderQueue> {
  final Stream<QuerySnapshot> order_list =
      FirebaseFirestore.instance.collection('orders').snapshots();

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
              final order =
                  Order(name: data.docs[index]['foodName'], notes: '');
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
                                order.name,
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
                      order.notes == null
                          ? const Text(
                              'Notes:',
                              style: TextStyle(fontSize: 20),
                            )
                          : Text(
                              'Notes: \n${order.notes}',
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                      Container(
                        height: 50,
                        width: 100,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: InkWell(
                              child: const Text(
                                'Done',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {},
                            ),
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
