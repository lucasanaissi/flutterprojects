import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/page_tile.dart';

import '../../screens/favorites/favorites_screen.dart';
import '../../stores/page_store.dart';

class PageSection extends StatelessWidget {

  final PageStore pageStore = GetIt.I<PageStore>();

  PageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageTile(
          label: 'Anúncios',
          iconData: Icons.list,
          onTap: (){
            pageStore.setPage(0);
          },
          highlighted: pageStore.page == 0,
        ),
        PageTile(
          label: 'Inserir Anúncio',
          iconData: Icons.edit,
          onTap: (){
            pageStore.setPage(1);
          },
          highlighted: pageStore.page == 1,
        ),
        PageTile(
          label: 'Notificações',
          iconData: Icons.notifications_outlined,
          onTap: (){
            pageStore.setPage(2);
          },
          highlighted: pageStore.page == 2,
        ),
        PageTile(
          label: 'Chat',
          iconData: Icons.chat_bubble_outline,
          onTap: (){
            pageStore.setPage(3);
          },
          highlighted: pageStore.page == 3,
        ),
        PageTile(
          label: 'Favoritos',
          iconData: Icons.favorite_outline,
          onTap: (){
            Navigator.of(context).pop();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const FavoritesScreen()));
          },
          highlighted: pageStore.page == 4,
        ),
        PageTile(
          label: 'Minha Conta',
          iconData: Icons.person_outline,
          onTap: (){
            pageStore.setPage(5);
          },
          highlighted: pageStore.page == 5,
        ),
        const Divider(),
        PageTile(
          label: 'Pagamentos',
          iconData: Icons.payments,
          onTap: (){
            pageStore.setPage(6);
          },
          highlighted: pageStore.page == 6,
        ),
        const Divider(),
      ],
    );
  }
}
