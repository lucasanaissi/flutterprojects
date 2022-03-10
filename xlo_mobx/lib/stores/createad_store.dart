import 'package:mobx/mobx.dart';

part 'createad_store.g.dart';

class CreateadStore = _CreateadStore with _$CreateadStore;

abstract class _CreateadStore with Store {

  ObservableList images = ObservableList();
}