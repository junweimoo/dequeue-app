import 'package:first_app/Customer_screens/Customer_main.dart';
import 'package:first_app/Customer_screens/Customer_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Food.dart';

class CustomerFoodDetail extends StatefulWidget {
  //const LoginForm({ Key? key }) : super(key: key);
  static const routeName = '/customer-food-detail';

  @override
  State<CustomerFoodDetail> createState() => _CustomerFoodDetailState();
}

class _CustomerFoodDetailState extends State<CustomerFoodDetail> {
  String notes;

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    final List args = ModalRoute.of(context).settings.arguments as List;
    final Food food = args[0];
    final String foodId = args[1];
    final String vendorId = args[2];
    final String canteenName = args[3];

    void orderItem() {
      FirebaseFirestore.instance.collection('orders').doc().set({
        'foodName': food.name,
        'notes': notes,
        'createdTime': Timestamp.now(),
        'done': false,
        'userId': user.uid,
        'vendorId': vendorId,
        'canteenName': canteenName,
        'price': food.price,
        'image': food.image,
      });
      Navigator.popUntil(context, (route) => route.isFirst);
    }

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(food.name),
          fit: BoxFit.contain,
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: Image.network(food.image),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 150,
                child: Card(
                  child: Center(
                    child: Text(
                      "\$" + food.price.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  color: Colors.lightGreen,
                ),
              ),
              Container(
                height: 50,
                width: 150,
                child: Card(
                  child: Center(
                    child: Text(
                      canteenName,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  color: Colors.lightGreen,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 1,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              onChanged: (value) {
                notes = value;
              },
              decoration: const InputDecoration(
                hintText: "Type your notes to the vendor here",
              ),
              maxLines: 3,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Container(
            height: 50,
            width: 150,
            child: Card(
              child: InkWell(
                onTap: orderItem,
                child: Column(
                  children: const [
                    Text(
                      'Order',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
