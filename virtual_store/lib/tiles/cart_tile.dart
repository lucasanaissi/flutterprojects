import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/datas/cart_product.dart';

import '../datas/product_data.dart';
import '../models/cart_model.dart';

class CartTile extends StatelessWidget {
  final CartProduct? cartProduct;

  const CartTile(this.cartProduct, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _buildContent() {
      CartModel.of(context).updatePrices();

      return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: 120,
            child: Image.network(
              cartProduct!.productData?.images![0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cartProduct!.productData!.title.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    'Tamanho ${cartProduct!.size}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    'R\$ ${cartProduct!.productData?.price?.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: cartProduct!.quantity! > 1
                            ? () {
                                CartModel.of(context).decProduct(cartProduct!);
                              }
                            : null,
                        icon: const Icon(
                          Icons.remove,
                        ),
                        color: Colors.purple,
                      ),
                      Text(
                        cartProduct!.quantity.toString(),
                      ),
                      IconButton(
                        onPressed: () {
                          CartModel.of(context).incProduct(cartProduct!);
                        },
                        icon: const Icon(
                          Icons.add,
                        ),
                        color: Colors.purple,
                      ),
                      TextButton(
                        onPressed: () {
                          CartModel.of(context).removeCartItem(cartProduct!);
                        },
                        child: const Text(
                          'Remover',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: cartProduct!.productData == null
            ? FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection("products")
                    .doc(cartProduct!.category)
                    .collection("itens")
                    .doc(cartProduct!.pid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    cartProduct!.productData =
                        ProductData.fromDocument(snapshot.data);
                    print(snapshot.data);
                    return _buildContent();
                  } else {
                    return Container(
                      height: 70.0,
                      child: const CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                },
              )
            : _buildContent());
  }
}
