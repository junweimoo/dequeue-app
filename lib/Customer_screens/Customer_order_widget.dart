import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Customer_order_widget extends StatelessWidget {
  //const MyWidget({Key key}) : super(key: key);
  final Map order;
  Customer_order_widget(
    @required this.order,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: [
            Padding(
              child: Text(
                order["foodName"],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              padding: EdgeInsets.all(10),
            ),
            Expanded(
              child: ClipRRect(
                child: Stack(
                  children: [
                    Image.network(
                      order['image'],
                      fit: BoxFit.fitWidth,
                    ),
                    Container(
                      child: Container(
                        color: Colors.black54,
                        width: 150,
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 22,
                                    color: Colors.white.withOpacity(0.95),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    order["canteenName"],
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 10,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.money_sharp,
                                    size: 22,
                                    color: Colors.white.withOpacity(0.95),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    order["price"].toString(),
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 10,
                              ),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                      ),
                      alignment: Alignment.bottomRight,
                    ),
                  ],
                  fit: StackFit.expand,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: const Color.fromARGB(173, 255, 255, 255),
      ),
      height: 250,
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 10,
        bottom: 15,
        right: 10,
      ),
    );
  }
}
