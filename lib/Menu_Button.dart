import 'package:first_app/Vendor_screen/Vendor_food_detail_screen.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String image;
  final String text;

  MenuButton({
    @required this.image,
    @required this.text,
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
              arguments: text,
            );
          },
          child: Column(
            children: [
              Image.network(
                image,
                fit: BoxFit.fitWidth,
                height: 80,
              ),
              Expanded(
                child: FittedBox(
                  child: Container(
                    child: Text(text),
                    margin: EdgeInsets.all(5),
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
