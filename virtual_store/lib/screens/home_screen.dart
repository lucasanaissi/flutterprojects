import 'package:flutter/material.dart';
import 'package:virtual_store/tabs/home_tab.dart';
import 'package:virtual_store/widgets/cart_button.dart';

import '../tabs/orders_tab.dart';
import '../tabs/places_tab.dart';
import '../tabs/products_tab.dart';
import '../widgets/custom_drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: const HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: const CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Produtos',
            ),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: const ProductsTab(),
          floatingActionButton: const CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Lojas',
            ),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: const PlacesTab(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Pedidos',
            ),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: const OrdersTab(),
        ),
      ],
    );
  }
}
