import 'package:first_app/Customer_screens/Customer_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodStallList extends StatefulWidget {
  //const FoodStallList({ Key? key }) : super(key: key);
  static const routeName = '/food-stalls';

  @override
  State<FoodStallList> createState() => _FoodStallListState();
}

class _FoodStallListState extends State<FoodStallList> {
  @override
  Widget build(BuildContext context) {
    final List args = ModalRoute.of(context).settings.arguments as List;
    final String canteenId = args[0];

    return Scaffold(
      appBar: AppBar(
        title: Text("Stalls"),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .where("canteenId", isEqualTo: canteenId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final data = snapshot.data;
            return GridView.builder(
              itemCount: data.docs.length,
              itemBuilder: (ctx, index) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      CustomerMenuScreen.routeName,
                      arguments: [data.docs[index].id],
                    );
                  },
                  child:
                      Text("${snapshot.data.docs[index].data()["username"]}"),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 2,
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
            );
          }
        },
      ),
    );
  }
}
