import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/food_items.dart';
import 'package:flutter_application_1/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItemTile extends StatelessWidget {
  final FoodItem item;
  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
      trailing: IconButton(
        icon: const Icon(Icons.remove_circle),
        onPressed: () {
          Provider.of<CartProvider>(context, listen: false).remove(item);
        },
      ),
    );
  }
}

extension on String {
  toStringAsFixed(int i) {}
}