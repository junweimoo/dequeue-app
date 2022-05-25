import 'package:first_app/Vendor_screen/Vendor_food_detail_screen.dart';
import 'package:flutter/material.dart';

import '../Food.dart';

class MenuButton extends StatelessWidget {
  final Food food;

  MenuButton({
    @required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              FoodDetailScreen.routeName,
              arguments: food,
            );
          },
          child: Column(
            children: [
              Image.network(
                food.image,
                fit: BoxFit.fitWidth,
                height: 80,
              ),
              Expanded(
                child: FittedBox(
                  child: Container(
                    child: Text(food.name),
                    margin: const EdgeInsets.all(5),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
