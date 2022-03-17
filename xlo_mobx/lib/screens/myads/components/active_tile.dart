import 'package:flutter/material.dart';
import 'package:xlo_mobx/helpers/extensions.dart';

import '../../../models/ad.dart';
import '../../ad/ad_screen.dart';

class ActiveTile extends StatelessWidget {
  ActiveTile({Key? key, required this.ad}) : super(key: key);

  final Ad ad;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar', iconData: Icons.edit),
    MenuChoice(index: 1, title: 'Já vendi', iconData: Icons.thumb_up),
    MenuChoice(index: 2, title: 'Excluir', iconData: Icons.delete),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AdScreen(ad: ad))
        );
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
                        ad.price!.formattedMoney(),
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
                  switch(choice.index) {
                    case 0:
                    case 1:
                    case 2:
                      break;
                  }
                },
                itemBuilder: (_) {
                  return choices.map((choice) =>
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
                          ))
                  ).toList();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuChoice {
  MenuChoice(
      {required this.index, required this.title, required this.iconData});

  final int index;
  final String title;
  final IconData iconData;
}
