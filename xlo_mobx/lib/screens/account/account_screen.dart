import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/favorites/favorites_screen.dart';
import 'package:xlo_mobx/screens/myads/myads_screen.dart';

import 'components/account_header_pane.dart';
import 'components/list_item_button.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 2,
        title: const Text(
          'Minha Conta',
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'EDITAR',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: ListView(
        children: [
          AccountHeaderPane(),
          ListItemButton(
              message: 'Meus anúncios',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyAdsScreen()));
              }),
          ListItemButton(
              message: 'Favoritos',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FavoritesScreen()));
              }),
          ListItemButton(message: 'Meu perfil', onTap: () {}),
        ],
      ),
    );
  }
}
