import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {

  final String orderId;

  const OrderScreen(this.orderId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido realizado'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check,
              color: Colors.purple,
              size: 80,
            ),
            const Text(
              'Pedido realizado com sucesso!',
              style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
            Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               const Text(
                 'Código do pedido: ',
                 style: const TextStyle(
                     color: Colors.purple,
                     fontWeight: FontWeight.bold,
                     fontSize: 16
                 ),
               ),
               Text(
                 '$orderId',
                 style: const TextStyle(
                     color: Colors.black,
                     fontWeight: FontWeight.w300,
                     fontSize: 16
                 ),
               ),
             ],
            )
          ],
        ),
      ),
    );
  }
}
