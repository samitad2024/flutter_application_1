import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/food_items.dart';

class CartProvider with ChangeNotifier {
  final Map<FoodItem, int> _items = {};
  final Set<FoodItem> _orderedItems = {};

  Map<FoodItem, int> get items => _items;
  Set<FoodItem> get orderedItems => _orderedItems;

  void add(FoodItem item) {
    if (_items.containsKey(item)) {
      _items[item] = _items[item]! + 1;
    } else {
      _items[item] = 1;
    }
    notifyListeners();
  }

  void remove(FoodItem item) {
    if (_items.containsKey(item)) {
      _items.remove(item);
      notifyListeners();
    }
  }

  void increaseQuantity(FoodItem item) {
    if (_items.containsKey(item)) {
      _items[item] = _items[item]! + 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(FoodItem item) {
    if (_items.containsKey(item) && _items[item]! > 1) {
      _items[item] = _items[item]! - 1;
      notifyListeners();
    } else {
      remove(item);
    }
  }

  double get totalPrice {
    double total = 0.0;
    _items.forEach((item, qty) {
      total += double.parse(item.price) * qty;
    });
    return total;
  }

  void markAllOrdered() {
    _orderedItems.addAll(_items.keys);
    notifyListeners();
  }

  void markOrdered(Iterable<FoodItem> items) {
    _orderedItems.addAll(items);
    notifyListeners();
  }

  bool isOrdered(FoodItem item) => _orderedItems.contains(item);
}
