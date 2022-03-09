import 'package:flutter/material.dart';
import 'package:dotted_decoration/dotted_decoration.dart';

class ImageField extends StatelessWidget {
  const ImageField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int imgQuantity = 0;

    return Container(
      color: Colors.grey.withAlpha(50),
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: (){},
        child: Container(
          height: 250,
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
                  '$imgQuantity de 20 adicionadas',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
