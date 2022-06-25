import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewFoodDialog extends StatefulWidget {
  // const NewFoodDialog({Key? key}) : super(key: key);

  @override
  State<NewFoodDialog> createState() => _NewFoodDialogState();
}

class _NewFoodDialogState extends State<NewFoodDialog> {
  String _foodName;
  double _price;

  _trySubmit() {
    print(_foodName);
    FirebaseFirestore.instance.collection('Food_items').doc().set({
      'name': _foodName,
      'price': _price,
      'vendorId': FirebaseAuth.instance.currentUser.uid,
      'imageUrl': ""
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Menu'),
      content: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onChanged: (value) {
                  _foodName = value;
                },
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value.length < 5) {
                    return "Please use a name longer than 4 characters";
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  _price = double.parse(value.replaceAll(",", ""));
                  ;
                },
                decoration: InputDecoration(
                    prefixText: NumberFormat.compactSimpleCurrency(locale: 'en')
                        .currencySymbol,
                    labelText: 'Price'),
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    decimalDigits: 2,
                    symbol: "",
                    locale: 'en',
                  )
                ],
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Add image'),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: _trySubmit,
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
