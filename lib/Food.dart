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

  static Food fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'],
      price: json['price'],
      image: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'imageUrl': image,
    };
  }
}
