import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/screens/categories/categories_screen.dart';

import '../../../stores/home_store.dart';
import 'bar_button.dart';
import '../../filter/filter_screen.dart';

class TopBar extends StatelessWidget {
  TopBar({Key? key}) : super(key: key);

  final HomeStore homeStore = GetIt.I<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BarButton(
          label: 'Região',
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey),
              right: BorderSide(color: Colors.grey),
            ),
          ),
          onTap: () {},
        ),
        Observer(
          builder: (_) {
            return BarButton(
              label: homeStore.category?.description ?? 'Categorias',
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                  right: BorderSide(color: Colors.grey),
                ),
              ),
              onTap: () async {
                final category = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CategoriesScreen(
                      showAll: true,
                      selected: homeStore.category,
                    ),
                  ),
                );
                if(category != null) {
                  homeStore.setCategory(category);
                }
              },
            );
          }
        ),
        BarButton(
          label: 'Filtros',
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => FilterScreen())
            );
          },
        ),
      ],
    );
  }
}
