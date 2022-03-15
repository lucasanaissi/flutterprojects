import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/stores/category_store.dart';

import '../../components/error_box.dart';
import '../../models/category.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key, this.showAll = true, this.selected})
      : super(key: key);

  final bool showAll;
  final Category? selected;

  final CategoryStore categoryStore = GetIt.I<CategoryStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Escolha uma categoria'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Observer(
          builder: (_) {
            if (categoryStore.error != null) {
              return ErrorBox(message: categoryStore.error);
            } else if (categoryStore.categoryList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.deepPurple,
                  ),
                ),
              );
            } else {
              final categories = showAll
                  ? categoryStore.allCategoryList
                  : categoryStore.categoryList;
              return ListView.separated(
                separatorBuilder: (_, __) {
                  return const Divider(
                    height: 0.1,
                    color: Colors.grey,
                  );
                },
                itemCount: categories.length,
                itemBuilder: (_, index) {
                  final category = categories[index];

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pop(category);
                    },
                    child: Container(
                      height: 50,
                      color: category.id == selected?.id
                          ? Colors.purple.withAlpha(50)
                          : null,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30,
                                right: 40,
                            ),
                            child: Text(
                              category.description,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
