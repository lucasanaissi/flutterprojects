import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/stores/home_store.dart';

import '../home/components/search_dialog.dart';
import 'components/ad_tile.dart';
import 'components/create_ad_button.dart';
import 'components/top_bar.dart';

class AdvertsScreen extends StatefulWidget {
  AdvertsScreen({Key? key}) : super(key: key);

  @override
  State<AdvertsScreen> createState() => _AdvertsScreenState();
}

class _AdvertsScreenState extends State<AdvertsScreen> {
  final HomeStore homeStore = GetIt.I<HomeStore>();

  final ScrollController scrollController = ScrollController();

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
            Expanded(
              child: Stack(
                children: [
                  Observer(
                    builder: (_) {
                      if (homeStore.error != null) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.error,
                              color: Colors.deepPurple,
                              size: 100,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Ocorreu um erro!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        );
                      }
                      if (homeStore.showProgress) {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.deepPurple,
                            ),
                          ),
                        );
                      }
                      if (homeStore.adList.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.border_clear,
                              color: Colors.deepPurple,
                              size: 100,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Nenhum anúncio encontrado.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        );
                      }
                      return ListView.builder(
                          controller: scrollController,
                          itemCount: homeStore.itemCount,
                          itemBuilder: (_, index) {
                            if (index < homeStore.adList.length) {
                              return AdTile(ad: homeStore.adList[index]);
                            }
                            homeStore.loadNextPage();
                            return const SizedBox(
                              height: 10,
                              child: LinearProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  Colors.deepPurple,
                                ),
                              ),
                            );
                          });
                    },
                  ),
                   Positioned(
                    bottom: -50,
                    left: 0,
                    child: CreateAdButton(scrollController: scrollController),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
