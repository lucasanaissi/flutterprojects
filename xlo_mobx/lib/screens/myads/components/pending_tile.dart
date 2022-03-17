import 'package:flutter/material.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/screens/ad/ad_screen.dart';

import '../../../models/ad.dart';

class PendingTile extends StatelessWidget {
  PendingTile({Key? key, required this.ad}) : super(key: key);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AdScreen(ad: ad))
        );
      },
      child: SizedBox(
        height: 100,
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
                  padding: const EdgeInsets.all(8.0),
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
                        ad.price!.formattedMoney(),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Anunciado dia ${ad.created!.formattedDate()}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[400],
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.error_outline,
                            color: Colors.orange,
                            size: 14,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Anuncio pendente!',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}