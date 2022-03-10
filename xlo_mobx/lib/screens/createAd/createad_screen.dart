import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:xlo_mobx/screens/categories/categories_screen.dart';
import 'package:xlo_mobx/stores/category_store.dart';
import 'package:xlo_mobx/stores/createad_store.dart';

import 'components/category_field.dart';
import 'components/images_field.dart';

class CreateAdScreen extends StatefulWidget {
  CreateAdScreen({Key? key}) : super(key: key);

  @override
  State<CreateAdScreen> createState() => _CreateAdScreenState();
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  final CreateadStore createadStore = CreateadStore();
  final CategoryStore categoryStore = CategoryStore();

  @override
  Widget build(BuildContext context) {
    var cepFormatter = MaskTextInputFormatter(
        mask: '#####-###',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Inserir anúncio'),
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
      drawer: const CustomDrawer(),
      body: ListView(
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              cursorColor: Colors.deepPurple,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),
                  isDense: true,
                  hintText: 'Ex: Samsung S9 novo na caixa'),
            ),
          ),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              minLines: 4,
              maxLines: 6,
              cursorColor: Colors.deepPurple,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),
                  isDense: true,
                  hintText:
                      'Ex: Smartphone Samsung Galaxy S9 com 128gb de memória, com caixa, todos os cabos e sem marcas de uso.'),
            ),
          ),
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
          const Padding(
            padding: EdgeInsets.only(right: 250, left: 20),
            child: TextField(
              cursorColor: Colors.deepPurple,
              decoration: InputDecoration(
                isDense: true,
                prefixText: 'R\$ ',
                hintText: '100.00',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 20),
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
            child: TextField(
              cursorColor: Colors.deepPurple,
              inputFormatters: [
                cepFormatter,
              ],
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding:
                const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 0,
                    bottom: 20,
                ),
            child: SizedBox(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  primary: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: const Text(
                  'Criar anúncio',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}