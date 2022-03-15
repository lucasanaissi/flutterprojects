import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';

import '../home/components/search_dialog.dart';

class AdvertsScreen extends StatelessWidget {
  const AdvertsScreen({Key? key}) : super(key: key);

  openSearch(BuildContext context) async {
    final String search =
        await showDialog(context: context, builder: (_) => SearchDialog(
          currentSearch: 'Teste'));
    print(search);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
                onPressed: () {
                  openSearch(context);
                },
                icon: const Icon(
                  Icons.search,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_outline,
                )),
          ],
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
