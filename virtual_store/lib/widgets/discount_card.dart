import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ExpansionTile(
        title: const Text(
          'Cupom de desconto',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        leading: const Icon(
          Icons.card_giftcard,
        ),
        trailing: const Icon(
          Icons.add,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite um cupom de desconto',
              ),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                FirebaseFirestore.instance
                    .collection('coupons')
                    .doc(text)
                    .get()
                    .then((docSnap) {
                  if (docSnap.data() != null) {
                    CartModel.of(context).setCoupon(text, docSnap.get('percent'));
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Desconto de ${docSnap.get('percent')}% aplicado.'),
                      backgroundColor: Colors.purple,
                    ));
                  } else {
                    CartModel.of(context).setCoupon(null, 0);
                    Scaffold.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          'Cupom inválido.'),
                      backgroundColor: Colors.red,
                    ));
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
