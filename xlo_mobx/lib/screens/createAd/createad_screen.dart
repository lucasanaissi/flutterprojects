import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/screens/categories/categories_screen.dart';
import 'package:xlo_mobx/screens/createAd/components/cep_field.dart';
import 'package:xlo_mobx/screens/myads/myads_screen.dart';
import 'package:xlo_mobx/stores/category_store.dart';
import 'package:xlo_mobx/stores/createad_store.dart';

import '../../models/ad.dart';
import '../../stores/page_store.dart';
import 'components/category_field.dart';
import 'components/hide_phone_field.dart';
import 'components/images_field.dart';

class CreateAdScreen extends StatefulWidget {
  const CreateAdScreen({Key? key, this.ad}) : super(key: key);

  final Ad? ad;

  @override
  State<CreateAdScreen> createState() => _CreateAdScreenState(ad);
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  _CreateAdScreenState(Ad? ad)
      : editing = ad != null,
        createadStore = ad != null ? CreateadStore(ad: ad) : CreateadStore();

  final CreateadStore createadStore;
  final CategoryStore categoryStore = CategoryStore();

  bool editing;

  @override
  void initState() {
    super.initState();

    when((_) => createadStore.savedAd, () {
      if(editing) {
        Navigator.of(context).pop(true);
      } else {
        GetIt.I<PageStore>().setPage(0);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const MyAdsScreen(initialPage: 1))
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(editing ? 'Editar anúncio' : 'Inserir anúncio'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'LIMPAR',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      drawer: editing ? null : const CustomDrawer(),
      body: Observer(
        builder: (_) {
          if (createadStore.loading) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Salvando anúncio',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.purple,
                      ),
                    ),
                    SizedBox(height: 16),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.purple),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return ListView(
              children: [
                ImagesField(createadStore: createadStore),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    'Título do anúncio*',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Observer(
                      builder: (_) {
                        return TextFormField(
                          initialValue: createadStore.title,
                          onChanged: createadStore.setTitle,
                          cursorColor: Colors.deepPurple,
                          decoration: InputDecoration(
                              errorText: createadStore.titleError,
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepPurple,
                                ),
                              ),
                              isDense: true,
                              hintText: 'Ex: Samsung S9 novo na caixa'),
                        );
                      },
                    )),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    'Descrição*',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Observer(
                      builder: (_) {
                        return TextFormField(
                          initialValue: createadStore.description,
                          onChanged: createadStore.setDescription,
                          minLines: 4,
                          maxLines: 6,
                          cursorColor: Colors.deepPurple,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepPurple,
                              ),
                            ),
                            isDense: true,
                            hintText:
                                'Ex: Smartphone Samsung Galaxy S9 com 128gb de memória, '
                                'com caixa, todos os cabos e sem marcas de uso.',
                            errorText: createadStore.descError,
                          ),
                        );
                      },
                    )),
                const SizedBox(height: 20),
                CategoryField(createadStore: createadStore),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    'Preço (R\$)',
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
                          initialValue: createadStore.price != null
                              ? createadStore.price.toString()
                              : '',
                          cursorColor: Colors.deepPurple,
                          onChanged: createadStore.setPrice,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixText: 'R\$ ',
                            hintText: '100.00',
                            errorText: createadStore.priceError,
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        );
                      },
                    )),
                const SizedBox(height: 20),
                CepField(createadStore: createadStore),
                const SizedBox(height: 5),
                HidePhoneField(createadStore: createadStore),
                const SizedBox(height: 4),
                Observer(
                  builder: (_) {
                    return ErrorBox(
                      message: createadStore.error,
                    );
                  },
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 0,
                    bottom: 20,
                  ),
                  child: Observer(
                    builder: (_) {
                      return SizedBox(
                        child: GestureDetector(
                          onTap: createadStore.invalidSendPressed,
                          child: ElevatedButton(
                            onPressed: createadStore.sendPressed,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(40),
                              primary: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: Text(
                              editing ? 'Editar anúncio' : 'Criar anúncio',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
