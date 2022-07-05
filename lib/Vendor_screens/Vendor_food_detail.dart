import 'package:first_app/Customer_screens/Customer_main.dart';
import 'package:first_app/Customer_screens/Customer_order_screen.dart';
import 'package:first_app/Vendor_screens/Vendor_main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Food.dart';

class VendorFoodDetail extends StatefulWidget {
  //const FoodDetailScreen({ Key? key }) : super(key: key);
  static const routeName = '/vendor-food-detail';

  @override
  State<VendorFoodDetail> createState() => _VendorFoodDetailState();
}

class _VendorFoodDetailState extends State<VendorFoodDetail> {
  final User user = FirebaseAuth.instance.currentUser;
  bool _onEdit;
  String _newName;
  double _newPrice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onEdit = false;
  }

  @override
  Widget build(BuildContext context) {
    final String foodId = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Food_items")
              .doc(foodId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final food = snapshot.data.data();

              return Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        child: Image.network(food["imageUrl"]),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(35)),
                      ),
                      Positioned(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey.withOpacity(0.7),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        bottom: 15,
                        left: 15,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          _onEdit
                              ? TextField(
                                  controller: TextEditingController(
                                    text: _newName,
                                  ),
                                  onChanged: (value) {
                                    _newName = value;
                                  },
                                )
                              : FittedBox(
                                  child: Text(
                                    food["name"],
                                    style: const TextStyle(
                                      fontSize: 30,
                                    ),
                                  ),
                                  fit: BoxFit.contain,
                                ),
                          SizedBox(
                            height: 5,
                          ),
                          _onEdit
                              ? TextField(
                                  controller: TextEditingController(
                                    text: _newPrice.toString(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    _newPrice = double.parse(value);
                                  },
                                )
                              : Text(
                                  "\$ ${food["price"].toString()}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      margin: EdgeInsets.all(20),
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_onEdit) {
                            FirebaseFirestore.instance
                                .collection("Food_items")
                                .doc(foodId)
                                .update({
                              "name": _newName,
                              "price": _newPrice,
                            });
                          }
                          setState(() {
                            _onEdit = !_onEdit;
                          });
                        },
                        child: _onEdit
                            ? const Text("Save")
                            : const Text('Edit item'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.orange.withOpacity(0.8),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          /* await FirebaseFirestore.instance
                        .collection("Food_items")
                        .doc(foodId)
                        .delete(); */
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: const Text('Delete item'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.red.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
