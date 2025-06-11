import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/provider/cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: ListView(
        children: cart.items
            .map((item) => ListTile(
                  title: Text(item.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () => cart.remove(item),
                  ),
                ))
            .toList(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Total: \$${cart.totalPrice.toStringAsFixed(2)}'),
      ),
    );
  }
}