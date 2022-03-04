import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();


  final Function(File) onImageSelected;

  ImageSourceSheet({
    Key? key,
    required this.onImageSelected
  }) : super(key: key);

  void imageSelected(XFile image) async {
    if (image != null) {
      File? croppedImage = await _cropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [CropAspectRatioPreset.square]
      );
      onImageSelected(croppedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () async {
              XFile? image =
                  (await _picker.pickImage(
                      source: ImageSource.camera)
                  );
              imageSelected(image!);
            },
            child: const Text('Câmera'),
          ),
          TextButton(
            onPressed: () async {
              XFile? image = (await _picker.pickImage(
                  source: ImageSource.gallery));
              imageSelected(image!);
            },
            child: const Text('Galeria'),
          ),
        ],
      ),
    );
  }
}
