import 'package:flutter/material.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/stores/myads_store.dart';

import '../../../models/ad.dart';

class SoldTile extends StatelessWidget {
  SoldTile({Key? key, required this.ad, required this.store}) : super(key: key);

  final Ad ad;
  final MyAdsStore store;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        child: Card(
          elevation: 8,
          child: Row(
            children: [
              SizedBox(
                height: 135,
                width: 127,
                child: Image.network(ad.images!.first),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ad.title!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Vendido dia ${ad.updatedAt?.formattedDate()}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    size: 15,
                    color: Colors.purple,
                  ),
                  onPressed: () {
                    store.deleteAd(ad);
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
