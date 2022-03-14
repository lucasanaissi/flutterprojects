import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/createad_store.dart';

class HidePhoneField extends StatelessWidget {
  HidePhoneField({Key? key, required this.createadStore}) : super(key: key);

  CreateadStore createadStore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Observer(
            builder: (_) {
              return Checkbox(
                value: createadStore.hidePhone,
                onChanged: createadStore.setHidePhone,
                activeColor: Colors.purple,
              );
            },
          ),
          const Text(
            'Ocultar o meu telefone neste anúncio',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
