import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageSourceModal extends StatelessWidget {
  ImageSourceModal({Key? key, required this.onImageSelected}) : super(key: key);

  final Function(File) onImageSelected;

  final ImagePicker _imgPicker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
          onClosing: () {},
          builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: getFromGallery,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.2),
                      child: Row(
                        children: const [
                          SizedBox(width: 10),
                          Icon(
                            Icons.image,
                            color: Colors.purple,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Utilizar imagem da galeria',
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: getFromCamera,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.2),
                      child: Row(
                        children: const [
                          SizedBox(width: 10),
                          Icon(
                            Icons.camera,
                            color: Colors.purple,
                          ),
                          SizedBox(width: 35),
                          Text(
                            'Tirar uma nova foto',
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ));
    } else {
      return CupertinoActionSheet(
        title: const Text('Selecionar foto para o anúncio'),
        message: const Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancelar'),
          onPressed: Navigator.of(context).pop,
        ),
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Galeria'),
            onPressed: getFromGallery,
          ),
          CupertinoActionSheetAction(
            child: const Text('Câmera'),
            onPressed: getFromCamera,
          ),
        ],
      );
    }
  }

  Future<void> getFromGallery() async {
    final pickedFile = await _imgPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    final image = File(pickedFile.path);
    imageSelected(image);
  }

  Future<void> getFromCamera() async {
    final pickedFile = await _imgPicker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;
    final image = File(pickedFile.path);
    imageSelected(image);
  }

  Future<void> imageSelected(File image) async {

    final croppedFile = await _cropper.cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Editar Imagem',
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
      ),
      iosUiSettings: const IOSUiSettings(
        title: 'Editar Imagem',
        cancelButtonTitle: 'Cancelar',
        doneButtonTitle: 'Concluir'
      )
    );
    if (croppedFile != null) {
      onImageSelected(croppedFile);
    } else {
      return;
    }
  }
}
