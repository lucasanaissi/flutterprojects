import 'package:flutter/material.dart';

import '../models/cart_model.dart';

class ShipCard extends StatelessWidget {
  const ShipCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ExpansionTile(
        title: const Text(
          'Calcular o frete',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        leading: const Icon(
          Icons.location_on,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite seu CEP',
              ),
              initialValue: "",
              onFieldSubmitted: (text) {
              },
            ),
          )
        ],
      ),
    );
  }
}
