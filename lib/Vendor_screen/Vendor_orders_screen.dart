import 'dart:collection';
import 'package:flutter/material.dart';

import '../Order.dart';
import '../DUMMY_ORDERS.dart';

class OrderQueue extends StatefulWidget {
  //const Queue({ Key? key }) : super(key: key);

  @override
  State<OrderQueue> createState() => _OrderQueueState();
}

class _OrderQueueState extends State<OrderQueue> {
  Queue<Order> queue = dummyOrders;

  void addNewOrder(Order order) {
    setState(() {
      queue.add(order);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: queue
            .map(
              (order) => Container(
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
                              color: Color.fromARGB(109, 121, 115, 115),
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
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
                              onTap: () {
                                setState(() {
                                  queue.removeFirst();
                                });
                              },
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
              ),
            )
            .toList(),
      ),
    );
  }
}
