import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../stores/myads_store.dart';
import 'components/active_tile.dart';
import 'components/pending_tile.dart';
import 'components/sold_tile.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({Key? key}) : super(key: key);

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  final MyAdsStore store = MyAdsStore();

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Meus anúncios',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              child: Observer(
                builder: (_) {
                  return Text(
                    'ATIVOS (${store.activeAds.length})',
                  );
                },
              ),
            ),
            Tab(
              child: Observer(
                builder: (_) {
                  return Text(
                    'PENDENTES (${store.pendingAds.length})',
                  );
                },
              ),
            ),
            Tab(
              child: Observer(
                builder: (_) {
                  return Text(
                    'VENDIDOS (${store.soldAds.length})',
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          Observer(
            builder: (_) {
              if (store.activeAds.isEmpty) {
                return Container();
              } else {
                return ListView.builder(
                  itemCount: store.activeAds.length,
                  itemBuilder: (_, index) {
                    return ActiveTile(ad: store.activeAds[index]);
                  },
                );
              }
            },
          ),
          Observer(
            builder: (_) {
              if (store.pendingAds.isEmpty) {
                return Container();
              } else {
                return ListView.builder(
                  itemCount: store.pendingAds.length,
                  itemBuilder: (_, index) {
                    return PendingTile(ad: store.pendingAds[index]);
                  },
                );
              }
            },
          ),
          Observer(
            builder: (_) {
              if (store.soldAds.isEmpty) {
                return Container();
              } else {
                return ListView.builder(
                  itemCount: store.soldAds.length,
                  itemBuilder: (_, index) {
                    return SoldTile(ad: store.soldAds[index]);
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
