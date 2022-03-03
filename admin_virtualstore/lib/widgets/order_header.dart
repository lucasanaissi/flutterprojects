import 'package:admin_virtualstore/widgets/order_header_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {

  final DocumentSnapshot<Object?> order;

  const OrderHeader({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderHeaderButton(order: order),
            ]
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Produtos: R\$${order.get('productsPrice').toStringAsFixed(2)}',
            ),
            Text(
              'Frete: R\$${order.get('shipPrice').toStringAsFixed(2)}',
            ),
            Text(
              'Preço total: R\$${order.get('totalPrice').toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ],
    );
  }
}
