import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/models/cart_model.dart';
import 'package:virtual_store/screens/login_screen.dart';
import 'package:virtual_store/screens/order_screen.dart';
import 'package:virtual_store/widgets/ship_card.dart';

import '../models/user_model.dart';
import '../tiles/cart_tile.dart';
import '../widgets/cart_price.dart';
import '../widgets/discount_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meu carrinho',
        ),
        centerTitle: true,
        actions: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 8),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int qProducts = model.products.length;
                return Text(
                  '$qProducts ${qProducts == 1 ? 'ITEM' : 'ITENS'}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(builder: (context, child, model) {
        if (model.isLoading && UserModel.of(context).isLoggedIn()) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!UserModel.of(context).isLoggedIn()) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.remove_shopping_cart,
                  size: 80,
                  color: Colors.purple,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Você precisa estar logado para adicionar produtos.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (model.products == null || model.products.length == 0) {
          return const Center(
            child: Text(
              'Nenhum produto no carrinho!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return ListView(
            children: [
              Column(
                children: model.products.map(
                    (product) {
                      return CartTile(product);
                    }
                ).toList(),
              ),
              const DiscountCard(),
              const ShipCard(),
              CartPrice(() async {
                String? orderId = await model.finishOrder();
                if(orderId != null){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => OrderScreen(orderId))
                  );
                }
              }),
            ],
          );
        }
      }),
    );
  }
}
