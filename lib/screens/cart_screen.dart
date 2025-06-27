import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/provider/cart_provider.dart';
import '../widgets/card_payment_section.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items;
    double subtotal = cart.totalPrice;
    double tax = subtotal * 0.10;
    double total = subtotal + tax;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Your Cart',
            style: TextStyle(color: Colors.black, fontSize: 15.0)),
        centerTitle: false,
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Color(0xFF5B3DF5),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
            icon: const Icon(Icons.admin_panel_settings, size: 20),
            label: const Text('Admin'),
            onPressed: () {
              // TODO: Navigate to admin page or show admin dialog
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${items.length} Item${items.length == 1 ? '' : 's'} in cart",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final item = items.keys.elementAt(index);
                  final qty = items[item]!;
                  return Container(
                    decoration: BoxDecoration(
                      color: cart.isOrdered(item)
                          ? Colors.green[50]
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                      border: cart.isOrdered(item)
                          ? Border.all(
                              color: const Color.fromRGBO(95, 33, 209, 1),
                              width: 2)
                          : null,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            item.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: cart.isOrdered(item)
                                        ? const Color.fromRGBO(75, 47, 236, 1)
                                        : Colors.black,
                                  )),
                              Text(item.description,
                                  style: const TextStyle(fontSize: 12)),
                              Row(
                                children: [
                                  if (!cart.isOrdered(item)) ...[
                                    IconButton(
                                      icon: const Icon(
                                          Icons.remove_circle_outline),
                                      onPressed: () =>
                                          cart.decreaseQuantity(item),
                                    ),
                                    Text('$qty',
                                        style: const TextStyle(fontSize: 14)),
                                    IconButton(
                                      icon:
                                          const Icon(Icons.add_circle_outline),
                                      onPressed: () =>
                                          cart.increaseQuantity(item),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline),
                                      color: Colors.red,
                                      onPressed: () => cart.remove(item),
                                    ),
                                  ] else ...[
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.red,
                                        minimumSize: const Size(40, 32),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      icon: const Icon(Icons.cancel, size: 16),
                                      label: const Text('Cancel',
                                          style: TextStyle(
                                            fontSize: 12,
                                          )),
                                      onPressed: () => cart.remove(item),
                                    ),
                                    const SizedBox(width: 6),
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.green,
                                        minimumSize: const Size(40, 32),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      icon: const Icon(Icons.check_circle,
                                          size: 16),
                                      label: const Text('Arrived',
                                          style: TextStyle(fontSize: 12)),
                                      onPressed: () => cart.remove(item),
                                    ),
                                  ],
                                ],
                              ),
                              Text('${qty} x ${item.price}',
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                        Text(
                            '${(double.parse(item.price) * qty).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: cart.isOrdered(item)
                                  ? Colors.green
                                  : Colors.black,
                            )),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Payment Method",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            // Card Payment Form
            CardPaymentSection(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal', style: TextStyle(fontSize: 16)),
                Text('\$${subtotal.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tax 10%', style: TextStyle(fontSize: 12)),
                Text('\$${tax.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.orange),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B3DF5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () async {
                  // Check if payment method is added
                  final prefs = await SharedPreferences.getInstance();
                  final cardNumber = prefs.getString('cardNumber');
                  final expiry = prefs.getString('expiry');
                  final name = prefs.getString('name');
                  if (cart.items.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        title: Row(
                          children: const [
                            Icon(Icons.shopping_cart, color: Color(0xFF5B3DF5)),
                            SizedBox(width: 8),
                            Text('Cart is empty',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        content: const Text('Please add items to your cart.',
                            style: TextStyle(fontSize: 16)),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xFF5B3DF5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  if (cardNumber == null || cardNumber.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        title: Row(
                          children: const [
                            Icon(Icons.credit_card, color: Color(0xFF5B3DF5)),
                            SizedBox(width: 8),
                            Text('No Payment Method',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        content: const Text('Please add a payment method.',
                            style: TextStyle(fontSize: 16)),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xFF5B3DF5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  // Only consider un-ordered items
                  final unOrderedItems = cart.items.keys
                      .where((item) => !cart.isOrdered(item))
                      .toList();
                  if (unOrderedItems.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        title: Row(
                          children: const [
                            Icon(Icons.info, color: Colors.orange),
                            SizedBox(width: 8),
                            Text('No New Items',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        content: const Text(
                            'All items in your cart are already ordered.',
                            style: TextStyle(fontSize: 16)),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xFF5B3DF5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  // Show approval dialog for only un-ordered items
                  final itemNames =
                      unOrderedItems.map((item) => item.name).join(', ');
                  final total = unOrderedItems.fold(
                          0.0,
                          (sum, item) =>
                              sum +
                              double.parse(item.price) * cart.items[item]!) *
                      1.10;
                  final approved = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      title: Row(
                        children: const [
                          Icon(Icons.checklist, color: Color(0xFF5B3DF5)),
                          SizedBox(width: 8),
                          Text('Approve Order',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      content: Text(
                          'Items: $itemNames\nTotal: \$${total.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16)),
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF5B3DF5),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Approve'),
                        ),
                      ],
                    ),
                  );
                  if (approved == true) {
                    cart.markOrdered(unOrderedItems);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        title: Row(
                          children: const [
                            Icon(Icons.celebration, color: Colors.green),
                            SizedBox(width: 8),
                            Text('Order Successful',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        content: const Text('Your order has been placed!',
                            style: TextStyle(fontSize: 16)),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xFF5B3DF5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text('Order',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: null,
    );
  }
}
