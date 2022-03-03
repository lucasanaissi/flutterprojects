import 'package:carousel_images/carousel_images.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/datas/cart_product.dart';
import 'package:virtual_store/datas/product_data.dart';
import 'package:virtual_store/screens/cart_screen.dart';
import 'package:virtual_store/screens/login_screen.dart';

import '../models/cart_model.dart';
import '../models/user_model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen(this.product, {Key? key}) : super(key: key);

  final ProductData product;

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;
  String? size;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    var array = product.images;
    List<String> itemsList = List<String>.from(array!);
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title!,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 0),
        children: [
          CarouselImages(
            height: 380,
            listImages: itemsList,
            borderRadius: 30.0,
            verticalAlignment: Alignment.center,
            scaleFactor: 0.1,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price?.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tamanho',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 34,
                  child: GridView(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.5,
                    ),
                    children: product.sizes!.map((s) {
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            size = s;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              border: Border.all(
                                color: s == size ? primaryColor : Colors.grey,
                                width: 3,
                              )),
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(
                            s,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                 SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: size != null ? (){
                      if(UserModel.of(context).isLoggedIn()){

                        CartProduct cartProduct = CartProduct();
                        cartProduct.size = size;
                        cartProduct.quantity = 1;
                        cartProduct.pid = product.id;
                        cartProduct.category = product.category;
                        cartProduct.productData = product;

                        CartModel.of(context).addCartItem(cartProduct);
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const CartScreen())
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      }
                    } : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn() ?
                      'Adicionar ao carrinho'
                      :
                      'Faça login para comprar',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Descrição do produto',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.desc!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
