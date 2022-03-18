import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:speech_balloon/speech_balloon.dart';
import 'package:xlo_mobx/stores/createad_store.dart';

import '../../../stores/cep_store.dart';

class CepField extends StatelessWidget {
  CepField({Key? key, required this.createadStore})
      : cepStore = createadStore.cepStore,
        super(key: key);

  CepStore cepStore;
  CreateadStore createadStore;

  @override
  Widget build(BuildContext context) {
    var cepFormatter = MaskTextInputFormatter(
        mask: '##.###-###',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
            left: 20,
            right: 20,
          ),
          child: Text(
            'CEP*',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 250, left: 20),
          child: Observer(
            builder: (_) {
              return TextFormField(
                initialValue: cepStore.cep,
                cursorColor: Colors.deepPurple,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  cepFormatter,
                ],
                onChanged: cepStore.setCep,
                decoration: InputDecoration(
                  errorText: createadStore.addressError,
                  isDense: true,
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Observer(
          builder: (_) {
            if (cepStore.address == null &&
                cepStore.error == null &&
                !cepStore.loading) {
              return Container();
            } else if (cepStore.address == null && cepStore.error == null) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: LinearProgressIndicator(
                  color: Colors.purple,
                  backgroundColor: Colors.transparent,
                ),
              );
            } else if (cepStore.error != null) {
              return Padding(
                padding: const EdgeInsets.only(left: 25, top: 8),
                child: SpeechBalloon(
                  nipLocation: NipLocation.topLeft,
                  color: Colors.red,
                  width: 250,
                  borderRadius: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                      Text(
                        cepStore.error.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(left: 25, top: 8),
                child: SpeechBalloon(
                  nipLocation: NipLocation.topLeft,
                  borderRadius: 5,
                  color: Colors.grey,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '${cepStore.address!.publicPlace}'
                          '\n${cepStore.address!.district}, '
                          '\n${cepStore.address!.city!.name} -'
                          ' ${cepStore.address!.uf!.initials} ',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
