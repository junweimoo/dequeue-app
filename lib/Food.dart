import 'package:flutter/cupertino.dart';

class Food with ChangeNotifier {
  String name;
  double price;
  String image;

  Food({
    @required this.name,
    @required this.price,
    @required this.image,
  });
}
