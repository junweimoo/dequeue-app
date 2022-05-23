import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Food.dart';

class FoodMenu with ChangeNotifier {
  List<Food> menuList;

  Stream<List<Food>> readFoodMenu() {
    return FirebaseFirestore.instance.collection('Food_items').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Food.fromJson(doc.data())).toList());
  }

  void addMenu(String name, double price, String ImageUrl) {
    var client = http.Client();
    try {
      final url = Uri.https(
          'project-dequeue-default-rtdb.asia-southeast1.firebasedatabase.app',
          'food_menu.json');
    } catch (error) {}
  }
}
