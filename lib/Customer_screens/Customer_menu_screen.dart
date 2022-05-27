import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Food_detail_screen.dart';
import '../Food.dart';

class CustomerMenuScreen extends StatefulWidget {
  //const CustomerMenuScreen({Key key}) : super(key: key);

  @override
  State<CustomerMenuScreen> createState() => _CustomerMenuScreenState();
}

class _CustomerMenuScreenState extends State<CustomerMenuScreen> {
  final Stream<QuerySnapshot> food_list =
      FirebaseFirestore.instance.collection('Food_items').snapshots();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
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
              return Expanded(
                child: ListView.builder(
                  itemCount: data.size,
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: InkWell(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                data.docs[index]['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Image.network(
                              data.docs[index]['imageUrl'],
                              height: 150,
                              fit: BoxFit.contain,
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            FoodDetailScreen.routeName,
                            arguments: [
                              Food(
                                image: data.docs[index]['imageUrl'],
                                name: data.docs[index]['name'],
                                price: data.docs[index]['price'].toDouble(),
                              ),
                              data.docs[index].id,
                              'customer',
                            ],
                          );
                        },
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Color.fromARGB(173, 255, 255, 255),
                    );
                  },
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
