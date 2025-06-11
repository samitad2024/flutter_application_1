import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/food_items.dart';

class CartProvider with ChangeNotifier {
  final List<FoodItem> _items = [];
  List<FoodItem> get items => _items;

  void  add(FoodItem item) {
    _items.add(item);
    notifyListeners();
  }
  void remove(FoodItem item) {
    _items.remove(item);
    notifyListeners();
  }
  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + double.parse(item.price));
  }
}
