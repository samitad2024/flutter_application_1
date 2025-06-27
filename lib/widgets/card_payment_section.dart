import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/card_payment_form.dart';

class CardPaymentSection extends StatefulWidget {
  const CardPaymentSection({super.key});

  @override
  State<CardPaymentSection> createState() => _CardPaymentSectionState();
}

class _CardPaymentSectionState extends State<CardPaymentSection> {
  Map<String, String>? savedCard;
  bool showForm = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCard();
  }

  Future<void> _loadSavedCard() async {
    final prefs = await SharedPreferences.getInstance();
    final cardNumber = prefs.getString('cardNumber');
    final expiry = prefs.getString('expiry');
    final name = prefs.getString('name');
    if (cardNumber != null && expiry != null && name != null) {
      setState(() {
        savedCard = {
          'cardNumber': cardNumber,
          'expiry': expiry,
          'name': name,
        };
      });
    }
  }

  Future<void> _saveCard(String cardNumber, String expiry, String name) async {
    setState(() {
      savedCard = {
        'cardNumber': cardNumber,
        'expiry': expiry,
        'name': name,
      };
      showForm = false;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cardNumber', cardNumber);
    await prefs.setString('expiry', expiry);
    await prefs.setString('name', name);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Card saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (showForm) CardPaymentForm(onSave: _saveCard),
        if (!showForm && (savedCard == null || savedCard!['cardNumber'] == null || savedCard!['cardNumber']!.isEmpty))
          TextButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add Card'),
            onPressed: () => setState(() => showForm = true),
          ),
        if (!showForm && savedCard != null && savedCard!['cardNumber'] != null && savedCard!['cardNumber']!.isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.5, // Decrease width to half of parent
              child: AspectRatio(
                aspectRatio: 16 / 10, // Typical card ratio, but smaller height
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFE259), Color(0xFFFFA751)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('VISA',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10)),
                                Row(
                                  children: [
                                    Icon(Icons.circle, color: Colors.red, size: 12),
                                    SizedBox(width: 2),
                                    Icon(Icons.circle, color: Colors.orange, size: 12),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              savedCard!['cardNumber'] != null && savedCard!['cardNumber']!.length == 16
                                  ? savedCard!['cardNumber']!.replaceAllMapped(RegExp(r"(\d{4})"), (match) => "${match.group(0)} ")
                                  : '',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Valid Thru',
                                        style: TextStyle(
                                            color: Colors.white70, fontSize: 5)),
                                    Text(
                                      savedCard!['expiry'] ?? '',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 6),
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.black,
                                  child: Center(
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                      icon: const Icon(Icons.add, color: Colors.white, size: 12),
                                      onPressed: () => setState(() => showForm = true),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              savedCard!['name'] ?? '',
                              style: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 6),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        
      ],
    );
  }
}