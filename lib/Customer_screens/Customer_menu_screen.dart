import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Food_detail_screen.dart';
import '../Food.dart';

class CustomerMenuScreen extends StatefulWidget {
  //const CustomerMenuScreen({Key key}) : super(key: key);
  static const routeName = '/food-stalls-menu';

  @override
  State<CustomerMenuScreen> createState() => _CustomerMenuScreenState();
}

class _CustomerMenuScreenState extends State<CustomerMenuScreen> {
  TextEditingController _searchController = TextEditingController();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final List args = ModalRoute.of(context).settings.arguments as List;
    final String vendorId = args[0];
    final Stream<QuerySnapshot> foodList = FirebaseFirestore.instance
        .collection('Food_items')
        .where("vendorId", isEqualTo: vendorId)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: foodList,
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
                if (searchText.length > 0) {
                  documents = documents.where((element) {
                    return element['name']
                        .toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase());
                  }).toList();
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        child: InkWell(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  documents[index]['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                child: ClipRRect(
                                  child: Image.network(
                                    documents[index]['imageUrl'],
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 150,
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              FoodDetailScreen.routeName,
                              arguments: [
                                Food(
                                  image: documents[index]['imageUrl'],
                                  name: documents[index]['name'],
                                  price: documents[index]['price'].toDouble(),
                                ),
                                documents[index].id,
                                'customer',
                                vendorId,
                              ],
                            );
                          },
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: const Color.fromARGB(173, 255, 255, 255),
                      );
                    },
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
