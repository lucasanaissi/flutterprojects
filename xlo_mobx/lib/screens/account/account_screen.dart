import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/account_data/account_data_screen.dart';
import 'package:xlo_mobx/screens/favorites/favorites_screen.dart';
import 'package:xlo_mobx/screens/myads/myads_screen.dart';

import '../../stores/user_manager_store.dart';
import 'components/list_item_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AccountDataScreen()));
            },
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
          Observer(
            builder: (_) {
              return Container(
                height: 200,
                color: Colors.deepPurple,
                alignment: Alignment.center,
                child: Text(
                  GetIt.I<UserManagerStore>().user!.name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              );
            },
          ),
          ListItemButton(
              message: 'Meus anúncios',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MyAdsScreen()));
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
