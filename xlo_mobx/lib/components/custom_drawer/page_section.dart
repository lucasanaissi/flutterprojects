import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/page_tile.dart';
import 'package:xlo_mobx/screens/login/login_screen.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import '../../screens/favorites/favorites_screen.dart';
import '../../stores/page_store.dart';

class PageSection extends StatelessWidget {
  final PageStore pageStore = GetIt.I<PageStore>();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  PageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> verifyLoginAndSetPage(int page) async {
      if (userManagerStore.isLoggedIn) {
        pageStore.setPage(page);
      } else {
        final result = await Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const LoginScreen()));
        if (result != null && result) {
          pageStore.setPage(page);
        }
      }
    }

    return Column(
      children: [
        PageTile(
          label: 'Anúncios',
          iconData: Icons.list,
          onTap: () {
            pageStore.setPage(0);
          },
          highlighted: pageStore.page == 0,
        ),
        PageTile(
          label: 'Inserir Anúncio',
          iconData: Icons.edit,
          onTap: () {
            verifyLoginAndSetPage(1);
          },
          highlighted: pageStore.page == 1,
        ),
        PageTile(
          label: 'Notificações',
          iconData: Icons.notifications_outlined,
          onTap: () {
            verifyLoginAndSetPage(2);
          },
          highlighted: pageStore.page == 2,
        ),
        PageTile(
          label: 'Chat',
          iconData: Icons.chat_bubble_outline,
          onTap: () {
            verifyLoginAndSetPage(3);
          },
          highlighted: pageStore.page == 3,
        ),
        PageTile(
          label: 'Favoritos',
          iconData: Icons.favorite_outline,
          onTap: () {
            verifyLoginAndSetPage(4);
          },
          highlighted: pageStore.page == 4,
        ),
        PageTile(
          label: 'Minha Conta',
          iconData: Icons.person_outline,
          onTap: () {
            verifyLoginAndSetPage(5);
            ;
          },
          highlighted: pageStore.page == 5,
        ),
        const Divider(),
        PageTile(
          label: 'Pagamentos',
          iconData: Icons.payments,
          onTap: () {
            verifyLoginAndSetPage(6);
          },
          highlighted: pageStore.page == 6,
        ),
        const Divider(),
      ],
    );
  }
}
