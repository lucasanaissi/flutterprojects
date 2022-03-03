import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/models/cart_model.dart';

class CartPrice extends StatelessWidget {
  const CartPrice(this.buy, {Key? key}) : super(key: key);

  final VoidCallback buy;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            double price = model.getProductsPrice();
            double discount = model.getDiscount();
            double ship = model.getShipPrice();

            double total = (price + ship) - discount;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Resumo do pedido',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal'),
                    Text('R\$ ${price.toStringAsFixed(2)}')
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text('Entrega'), Text('R\$ $ship')],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Desconto'),
                    Text('R\$ ${discount.toStringAsFixed(2)}')
                  ],
                ),
                const Divider(),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$ ${total.toStringAsFixed(2)}',
                      style:
                          const TextStyle(color: Colors.purple, fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: buy,
                  child: const Text(
                    'Finalizar pedido',
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
