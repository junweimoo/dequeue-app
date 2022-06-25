import 'package:first_app/Customer_screens/Customer_main.dart';
import 'package:first_app/Customer_screens/Customer_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Food.dart';

class CustomerFoodDetail extends StatelessWidget {
  //const FoodDetailScreen({ Key? key }) : super(key: key);
  static const routeName = '/customer-food-detail';

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    final List args = ModalRoute.of(context).settings.arguments as List;
    final Food food = args[0];
    final String foodId = args[1];
    final String type = args[2];
    final String vendorId = args[3];

    void orderItem() {
      FirebaseFirestore.instance.collection('orders').doc().set({
        'foodId': foodId,
        'foodName': food.name,
        'notes': '',
        'createdTime': Timestamp.now(),
        'done': false,
        'userId': user.uid,
        'vendorId': vendorId,
      });
      Navigator.pushReplacementNamed(
        context, CustomerHomePage.routeName,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(food.name),
          fit: BoxFit.contain,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Image.network(food.image),
              Text(
                "\$" + food.price.toString(),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            child: Container(
              height: 50,
              width: 150,
              //alignment: Alignment.center,
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
          ),
        ],
        alignment: Alignment.center,
      ),
    );
  }
}
