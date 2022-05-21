import 'dart:collection';

import './Order.dart';

Iterable<Order> x = [
  Order(
    name: 'Hokkien Mee',
    notes: 'Extra Noodles',
  ),
  Order(
    name: 'Carrot Cake',
  ),
  Order(
    name: 'Char Kway Teow',
  ),
  Order(
    name: 'Oyster Omelette',
  ),
];

final dummyOrders = Queue.of(x);
