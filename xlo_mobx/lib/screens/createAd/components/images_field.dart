import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/createAd/components/image_source_modal.dart';

import '../../../stores/createad_store.dart';
import 'image_dialog.dart';

class ImagesField extends StatelessWidget {
  const ImagesField({Key? key, required this.createadStore}) : super(key: key);

  final CreateadStore createadStore;

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File image) {
      createadStore.images.add(image);
      Navigator.of(context).pop();
    }

    return Container(
      color: Colors.grey.withAlpha(50),
      padding: const EdgeInsets.all(20),
      child: Observer(
        builder: (_) {
          return SizedBox(
            height: 250,
            width: 250,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: createadStore.images.length < 20
                  ? createadStore.images.length + 1
                  : 20,
              itemBuilder: (_, index) {
                if (index == createadStore.images.length) {
                  return GestureDetector(
                    onTap: () {
                      if (Platform.isAndroid) {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => ImageSourceModal(
                              onImageSelected: onImageSelected),
                        );
                      } else {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (_) => ImageSourceModal(
                              onImageSelected: onImageSelected),
                        );
                      }
                    },
                    child: Container(
                      height: 250,
                      width: index == 0 && index <= 1 ? 370 : 200,
                      decoration: DottedDecoration(
                        color: Colors.deepPurple,
                        shape: Shape.box,
                        borderRadius: BorderRadius.circular(10),
                        strokeWidth: 2,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.camera_alt_outlined,
                              size: 60,
                              color: Colors.deepPurple,
                            ),
                            const Text(
                              'Incluir fotos',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '${createadStore.images.length} de 20 adicionadas',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => ImageDialog(
                                  image: createadStore.images[index],
                                  onDelete: () =>
                                      createadStore.images.removeAt(index),
                                ));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: SizedBox(
                          height: 250,
                          width: 250,
                          child: Image.file(
                            createadStore.images[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
