import 'package:flutter/material.dart';

class CardPaymentForm extends StatefulWidget {
  final Function(String cardNumber, String expiry, String name) onSave;
  const CardPaymentForm({super.key, required this.onSave});

  @override
  State<CardPaymentForm> createState() => _CardPaymentFormState();
}

class _CardPaymentFormState extends State<CardPaymentForm> {
  final _formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiry = '';
  String name = '';


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Card Number'),
            keyboardType: TextInputType.number,
            maxLength: 16,
            onSaved: (val) => cardNumber = val ?? '',
            validator: (val) => val != null && val.length == 16
                ? null
                : 'Enter a 16-digit card number',
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
            keyboardType: TextInputType.datetime,
            onSaved: (val) => expiry = val ?? '',
            validator: (val) =>
                val != null && val.length == 5 ? null : 'Enter valid expiry',
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Cardholder Name'),
            onSaved: (val) => name = val ?? '',
            validator: (val) =>
                val != null && val.isNotEmpty ? null : 'Enter name',
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                widget.onSave(cardNumber, expiry, name);
              }
            },
            child: const Text('Save Card'),
          ),
        ],
      ),
    );
  }
}
