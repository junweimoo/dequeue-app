import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Customer_order_widget extends StatelessWidget {
  //const MyWidget({Key key}) : super(key: key);
  final order;
  Customer_order_widget(
    @required this.order,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("Food_items")
          .doc(order["foodId"])
          .get(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data.data();
          return Container(
            child: Card(
              child: Column(
                children: [
                  Padding(
                    child: Text(
                      "${data["name"]}",
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
                            data['imageUrl'],
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
                                          "The Deck",
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
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
                                          "\$${data["price"]}",
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
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
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
