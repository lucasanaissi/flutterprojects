import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/stores/home_store.dart';

import '../home/components/search_dialog.dart';
import 'components/top_bar.dart';

class AdvertsScreen extends StatelessWidget {
  AdvertsScreen({Key? key}) : super(key: key);

  final HomeStore homeStore = GetIt.I<HomeStore>();

  openSearch(BuildContext context) async {
    final String? search = await showDialog(
        context: context,
        builder: (_) => SearchDialog(currentSearch: homeStore.search));
    if (search != null) {
      homeStore.setSearch(search);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Observer(
            builder: (_) {
              if (homeStore.search.isEmpty) {
                return Container();
              } else {
                return GestureDetector(
                  onTap: () {
                    openSearch(context);
                  },
                  child: LayoutBuilder(
                    builder: (_, constraints) {
                      return Container(
                        width: constraints.biggest.width,
                        child: Text(homeStore.search),
                      );
                    },
                  ),
                );
              }
            },
          ),
          actions: [
            Observer(
              builder: (_) {
                if (homeStore.search.isEmpty) {
                  return IconButton(
                    onPressed: () {
                      openSearch(context);
                    },
                    icon: const Icon(
                      Icons.search,
                    ),
                  );
                } else {
                  return IconButton(
                    onPressed: () {
                      homeStore.setSearch('');
                    },
                    icon: const Icon(
                      Icons.clear,
                    ),
                  );
                }
              },
            ),
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
        body: Column(
          children: [
            TopBar(),
          ],
        ),
      ),
    );
  }
}
