import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    super.initState();
    _onEdit = false;
  }

  @override
  Widget build(BuildContext context) {
    final String foodId = ModalRoute.of(context).settings.arguments as String;

    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: const Text(
          "Cancel",
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = TextButton(
        child: const Text("Confirm"),
        onPressed: () {
          if (_onEdit) {
            if (_newName != null && _newPrice != null) {
              FirebaseFirestore.instance
                  .collection("Food_items")
                  .doc(foodId)
                  .update({
                "name": _newName,
                "price": _newPrice,
              });
            } else if (_newName != null) {
              FirebaseFirestore.instance
                  .collection("Food_items")
                  .doc(foodId)
                  .update({
                "name": _newName,
              });
            } else if (_newPrice != null) {
              FirebaseFirestore.instance
                  .collection("Food_items")
                  .doc(foodId)
                  .update({
                "price": _newPrice,
              });
            }
            Navigator.popUntil(context, (route) => route.isFirst);
          } else {
            /* await FirebaseFirestore.instance
                        .collection("Food_items")
                        .doc(foodId)
                        .delete(); */
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        content: _onEdit
            ? const Text("Press confirm to edit the item")
            : const Text("Press confirm to delete the item"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

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
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(35)),
                      ),
                      Positioned(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey.withOpacity(0.7),
                          child: IconButton(
                            icon: const Icon(
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
                                    text: food["name"],
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
                          const SizedBox(
                            height: 5,
                          ),
                          _onEdit
                              ? TextField(
                                  controller: TextEditingController(
                                    text: food["price"].toStringAsFixed(2),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    _newPrice = double.tryParse(value);
                                  },
                                )
                              : Text(
                                  "\$ ${food["price"].toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      margin: const EdgeInsets.all(20),
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_onEdit) {
                            if (_newName != null || _newPrice != null) {
                              showAlertDialog(context);
                            }
                          } else {
                            setState(() {
                              _onEdit = !_onEdit;
                            });
                          }
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
                          if (_onEdit) {
                            setState(() {
                              _onEdit = !_onEdit;
                            });
                          } else {
                            showAlertDialog(context);
                          }
                        },
                        child: _onEdit
                            ? const Text('Discard changes')
                            : const Text('Delete item'),
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
