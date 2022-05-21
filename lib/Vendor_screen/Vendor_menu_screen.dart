import 'package:flutter/material.dart';

import '../DUMMY_FOOD.dart';
import '../Menu_Button.dart';

class VendorMenu extends StatefulWidget {
  //const CanteenList({ Key? key }) : super(key: key);

  @override
  State<VendorMenu> createState() => _VendorMenuState();
}

class _VendorMenuState extends State<VendorMenu> {
  @override
  Widget build(BuildContext context) {
    return GridView(
      children: FoodMenu.DUMMY_FOOD
          .map((food) => MenuButton(
                text: food.name,
                image: food.image,
              ))
          .toList(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3 / 2,
        crossAxisCount: 2,
      ),
      shrinkWrap: true,
    );
  }
}
