// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createad_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateadStore on _CreateadStore, Store {
  final _$categoryAtom = Atom(name: '_CreateadStore.category');

  @override
  Category? get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(Category? value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  final _$_CreateadStoreActionController =
      ActionController(name: '_CreateadStore');

  @override
  void setCategory(Category value) {
    final _$actionInfo = _$_CreateadStoreActionController.startAction(
        name: '_CreateadStore.setCategory');
    try {
      return super.setCategory(value);
    } finally {
      _$_CreateadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
category: ${category}
    ''';
  }
}
