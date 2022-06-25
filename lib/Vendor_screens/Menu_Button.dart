import 'package:first_app/Vendor_screens/Vendor_food_detail.dart';
import 'package:flutter/material.dart';

import '../Food.dart';

class MenuButton extends StatelessWidget {
  final Food food;
  final String foodId;

  MenuButton({
    @required this.food,
    @required this.foodId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              VendorFoodDetail.routeName,
              arguments: [
                food,
                foodId,
                'vendor',
                "",
              ],
            );
          },
          child: Column(
            children: [
              Container(
                child: ClipRRect(
                  child: Image.network(
                    food.image,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
      ),
    );
  }
}
