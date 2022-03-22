import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/screens/account/account_screen.dart';
import 'package:xlo_mobx/screens/favorites/favorites_screen.dart';
import 'package:xlo_mobx/stores/connectivity_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';

import '../adverts/adverts_screen.dart';
import '../createAd/createad_screen.dart';
import '../offline/offline_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController();

  final PageStore pageStore = GetIt.I<PageStore>();
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  @override
  void initState() {
    super.initState();

    reaction(
      (_) => pageStore.page,
      (page) => pageController.jumpToPage(page as int),
    );

    autorun(
      (_) {
        if (!connectivityStore.connected) {
          Future.delayed(const Duration(milliseconds: 50)).then((value) {
            showDialog(context: context, builder: (_) => const OfflineScreen());
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          AdvertsScreen(),
          CreateAdScreen(),
          Container(color: Colors.green),
          Container(color: Colors.green),
          FavoritesScreen(),
          const AccountScreen(),
        ],
      ),
    );
  }
}
