import 'package:mobx/mobx.dart';

import '../models/category.dart';

part 'createad_store.g.dart';

class CreateadStore = _CreateadStore with _$CreateadStore;

abstract class _CreateadStore with Store {

  ObservableList images = ObservableList();

  @observable
  Category? category;

  @action
  void setCategory(Category value) => category = value;
}