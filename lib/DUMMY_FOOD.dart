import 'package:flutter/material.dart';

import 'Food.dart';

class FoodMenu with ChangeNotifier {
  static final DUMMY_FOOD = [
    Food(
      name: 'Spaghetti with Tomato Sauce',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
      price: 20,
    ),
    Food(
      name: 'Toast Hawaii',
      image:
          'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
      price: 10,
    ),
    Food(
      name: 'Classic Hamburger',
      image:
          'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
      price: 45,
    ),
    Food(
      name: 'Wiener Schnitzel',
      image:
          'https://cdn.pixabay.com/photo/2018/03/31/19/29/schnitzel-3279045_1280.jpg',
      price: 60,
    ),
    Food(
      name: 'Salad with Smoked Salmon',
      image:
          'https://cdn.pixabay.com/photo/2016/10/25/13/29/smoked-salmon-salad-1768890_1280.jpg',
      price: 15,
    ),
    Food(
      name: 'Delicious Orange Mousse',
      image:
          'https://cdn.pixabay.com/photo/2017/05/01/05/18/pastry-2274750_1280.jpg',
      price: 240,
    ),
    Food(
      name: 'Pancakes',
      image:
          'https://cdn.pixabay.com/photo/2018/07/10/21/23/pancake-3529653_1280.jpg',
      price: 20,
    ),
    Food(
      name: 'Creamy Indian Chicken Curry',
      image:
          'https://cdn.pixabay.com/photo/2018/06/18/16/05/indian-food-3482749_1280.jpg',
      price: 35,
    ),
    Food(
      name: 'Chocolate Souffle',
      image:
          'https://cdn.pixabay.com/photo/2014/08/07/21/07/souffle-412785_1280.jpg',
      price: 45,
    ),
    Food(
      name: 'Asparagus Salad with Cherry Tomatoes',
      image:
          'https://cdn.pixabay.com/photo/2018/04/09/18/26/asparagus-3304997_1280.jpg',
      price: 30,
    ),
  ];

  Food findByName(String name) {
    return DUMMY_FOOD.firstWhere((food) => food.name == name);
  }
}
