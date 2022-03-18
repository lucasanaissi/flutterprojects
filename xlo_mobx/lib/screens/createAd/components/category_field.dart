import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/stores/category_store.dart';
import 'package:xlo_mobx/stores/createad_store.dart';

import '../../../models/category.dart';
import '../../categories/categories_screen.dart';

class CategoryField extends StatelessWidget {
  CategoryField({Key? key, required this.createadStore}) : super(key: key);

  final TextEditingController? _categoryController = TextEditingController();
  final CreateadStore createadStore;

  final CategoryStore categoryStore = GetIt.I<CategoryStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                left: 20,
                right: 20,
              ),
              child: Text(
                'Categoria*',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Category? response = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoriesScreen(
                      showAll: false,
                      selected: createadStore.category,
                    ),
                  ),
                );
                if (response != null) {
                  _categoryController?.text = response.description;
                  createadStore.setCategory(response);
                }
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    enabled: false,
                    initialValue: createadStore.category != null
                        ? createadStore.category!.description
                        : null,
                    controller: createadStore.category != null
                        ? null
                        : _categoryController,
                    cursorColor: Colors.deepPurple,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Selecione uma categoria',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  )),
            ),
            if (createadStore.categoryError != null)
              Container(
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.red)),
                ),
                padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                child: Text(
                  createadStore.categoryError!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
