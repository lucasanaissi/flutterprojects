import 'package:flutter/material.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/screens/adverts/components/create_ad_button.dart';
import 'package:xlo_mobx/screens/createAd/createad_screen.dart';

import '../../../models/ad.dart';
import '../../../stores/myads_store.dart';
import '../../ad/ad_screen.dart';

class ActiveTile extends StatelessWidget {
  ActiveTile({Key? key, required this.ad, required this.store})
      : super(key: key);

  final Ad ad;
  final MyAdsStore store;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar', iconData: Icons.edit),
    MenuChoice(index: 1, title: 'Já vendi', iconData: Icons.thumb_up),
    MenuChoice(index: 2, title: 'Excluir', iconData: Icons.delete),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => AdScreen(ad: ad)));
      },
      child: SizedBox(
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
                        ad.price.formattedMoney(),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Visitas: ${ad.views}',
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
              PopupMenuButton<MenuChoice>(
                onSelected: (choice) {
                  switch (choice.index) {
                    case 0:
                      editAd(context);
                      break;
                    case 1:
                      soldAd(context);
                      break;
                    case 2:
                      deleteAd(context);
                      break;
                  }
                },
                itemBuilder: (_) {
                  return choices
                      .map((choice) =>
                      PopupMenuItem<MenuChoice>(
                          value: choice,
                          child: Row(
                            children: [
                              Icon(
                                choice.iconData,
                                size: 20,
                                color: Colors.purple,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                choice.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.purple,
                                ),
                              )
                            ],
                          )))
                      .toList();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editAd(BuildContext context) async {
    final success = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => CreateAdScreen(ad: ad)));
    if (success != null && success) {
      store.refresh();
    }
  }

  Future<void> soldAd(BuildContext context) async {
    showDialog(context: context, builder: (_) =>
        AlertDialog(
          title: Text('Vendido'),
          content: Text('Confirmar a venda de: ${ad.title}?'),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                store.soldAd(ad);
              },
              child: const Text('Sim',
                style: TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> deleteAd(BuildContext context) async {
    showDialog(context: context, builder: (_) =>
        AlertDialog(
          title: Text('Excluir'),
          content: Text('Excluir ${ad.title}?'),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                store.deleteAd(ad);
                store.refresh();
              },
              child: const Text('Sim',
                style: TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ],
        ));
  }
}

class MenuChoice {
  MenuChoice(
      {required this.index, required this.title, required this.iconData});

  final int index;
  final String title;
  final IconData iconData;
}
