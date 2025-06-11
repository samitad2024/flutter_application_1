import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/food_items.dart';
import 'package:flutter_application_1/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class FoodItemTile extends StatelessWidget {
  final FoodItem item;
  const FoodItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        ListTile(
          
          leading: Image.asset(
            item.imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood),
          ),
          title: Text(item.name),
          subtitle: Text(item.description),
          trailing: Text("\$${item.price}"),
          onTap: () {
            Provider.of<CartProvider>(context, listen: false).add(item);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${item.name} added to cart!"),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
      ],
    );
  }
}



