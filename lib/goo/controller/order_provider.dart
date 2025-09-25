import 'package:flutter/material.dart';

import '../models/models.dart';

class OrderProvider extends ChangeNotifier {
  final List<CityModel> _orders = [];

  List<CityModel> get orders => List.unmodifiable(_orders);

  void addOrder(CityModel city) {
    _orders.add(city);
    notifyListeners();
  }

  void removeOrder(CityModel city) {
    _orders.remove(city);
    notifyListeners();
  }

  bool isAlreadyOrdered(CityModel city) {
    return _orders.any((order) => order.name == city.name);
  }
}
