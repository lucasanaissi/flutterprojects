import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/stores/favorite_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';
import '../../models/ad.dart';
import 'components/announcer_tile.dart';
import 'components/bottom_bar.dart';

class AdScreen extends StatelessWidget {
  AdScreen({Key? key, required this.ad}) : super(key: key);

  final Ad ad;
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Anúncio',
        ),
        actions: [
          if (ad.status == AdStatus.ACTIVE && userManagerStore.isLoggedIn)
            Observer(builder: (_) {
              return IconButton(
                icon: Icon(
                  favoriteStore.favoriteList.any((a) => a.id == ad.id)
                      ? Icons.favorite
                      : Icons.favorite_outline,
                ),
                onPressed: () => favoriteStore.toggleFavorite(ad),
              );
            }),
          IconButton(
            icon: const Icon(
              Icons.share,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(top: 0),
            children: [
              SizedBox(
                height: 200,
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                  ),
                  items: ad.images!.map((url) => Image.network(url)).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 12, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ad.price.formattedMoney(),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      ad.title!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 18),
                    Text(
                      'Publicado em: ${ad.created!.formattedDate()}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 8, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      ad.description!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 8, bottom: 12, right: 150),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Localização',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'CEP',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          ad.address!.cep!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Municipio',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          ad.address!.city!.name!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Bairro',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          ad.address!.district!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              AnnouncerTile(ad: ad),
              SizedBox(height: ad.status == AdStatus.PENDING ? 16 : 80),
            ],
          ),
          BottomBar(ad: ad),
        ],
      ),
    );
  }
}
