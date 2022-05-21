import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../DUMMY_FOOD.dart';

class FoodDetailScreen extends StatelessWidget {
  //const FoodDetailScreen({ Key? key }) : super(key: key);
  static const routeName = '/food-detail';

  @override
  Widget build(BuildContext context) {
    final foodName = ModalRoute.of(context).settings.arguments as String;
    final food =
        Provider.of<FoodMenu>(context, listen: false).findByName(foodName);
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(foodName),
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text('Edit name'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('Edit price'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('Edit photo'),
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        height: MediaQuery.of(context).size.height / 2,
                        alignment: Alignment.center,
                      ),
                    );
                  });
            },
            icon: Icon(Icons.mode_edit_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          Image.network(food.image),
          Text(food.price.toString()),
        ],
      ),
    );
  }
}
