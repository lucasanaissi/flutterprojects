// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createad_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateadStore on _CreateadStore, Store {
  Computed<bool>? _$imagesValidComputed;

  @override
  bool get imagesValid =>
      (_$imagesValidComputed ??= Computed<bool>(() => super.imagesValid,
              name: '_CreateadStore.imagesValid'))
          .value;
  Computed<bool>? _$titleValidComputed;

  @override
  bool get titleValid =>
      (_$titleValidComputed ??= Computed<bool>(() => super.titleValid,
              name: '_CreateadStore.titleValid'))
          .value;
  Computed<bool>? _$descValidComputed;

  @override
  bool get descValid =>
      (_$descValidComputed ??= Computed<bool>(() => super.descValid,
              name: '_CreateadStore.descValid'))
          .value;
  Computed<bool>? _$categoryValidComputed;

  @override
  bool get categoryValid =>
      (_$categoryValidComputed ??= Computed<bool>(() => super.categoryValid,
              name: '_CreateadStore.categoryValid'))
          .value;
  Computed<num?>? _$priceComputed;

  @override
  num? get price => (_$priceComputed ??=
          Computed<num?>(() => super.price, name: '_CreateadStore.price'))
      .value;
  Computed<Address?>? _$addressComputed;

  @override
  Address? get address =>
      (_$addressComputed ??= Computed<Address?>(() => super.address,
              name: '_CreateadStore.address'))
          .value;
  Computed<bool>? _$formValidComputed;

  @override
  bool get formValid =>
      (_$formValidComputed ??= Computed<bool>(() => super.formValid,
              name: '_CreateadStore.formValid'))
          .value;
  Computed<dynamic>? _$sendPressedComputed;

  @override
  dynamic get sendPressed =>
      (_$sendPressedComputed ??= Computed<dynamic>(() => super.sendPressed,
              name: '_CreateadStore.sendPressed'))
          .value;

  final _$titleAtom = Atom(name: '_CreateadStore.title');

  @override
  String? get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String? value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$descriptionAtom = Atom(name: '_CreateadStore.description');

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

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

  final _$priceTextAtom = Atom(name: '_CreateadStore.priceText');

  @override
  String? get priceText {
    _$priceTextAtom.reportRead();
    return super.priceText;
  }

  @override
  set priceText(String? value) {
    _$priceTextAtom.reportWrite(value, super.priceText, () {
      super.priceText = value;
    });
  }

  final _$hidePhoneAtom = Atom(name: '_CreateadStore.hidePhone');

  @override
  bool? get hidePhone {
    _$hidePhoneAtom.reportRead();
    return super.hidePhone;
  }

  @override
  set hidePhone(bool? value) {
    _$hidePhoneAtom.reportWrite(value, super.hidePhone, () {
      super.hidePhone = value;
    });
  }

  final _$showErrorsAtom = Atom(name: '_CreateadStore.showErrors');

  @override
  bool get showErrors {
    _$showErrorsAtom.reportRead();
    return super.showErrors;
  }

  @override
  set showErrors(bool value) {
    _$showErrorsAtom.reportWrite(value, super.showErrors, () {
      super.showErrors = value;
    });
  }

  final _$loadingAtom = Atom(name: '_CreateadStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$errorAtom = Atom(name: '_CreateadStore.error');

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$savedAdAtom = Atom(name: '_CreateadStore.savedAd');

  @override
  bool get savedAd {
    _$savedAdAtom.reportRead();
    return super.savedAd;
  }

  @override
  set savedAd(bool value) {
    _$savedAdAtom.reportWrite(value, super.savedAd, () {
      super.savedAd = value;
    });
  }

  final _$_sendAsyncAction = AsyncAction('_CreateadStore._send');

  @override
  Future<void> _send() {
    return _$_sendAsyncAction.run(() => super._send());
  }

  final _$_CreateadStoreActionController =
      ActionController(name: '_CreateadStore');

  @override
  void setTitle(String value) {
    final _$actionInfo = _$_CreateadStoreActionController.startAction(
        name: '_CreateadStore.setTitle');
    try {
      return super.setTitle(value);
    } finally {
      _$_CreateadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String value) {
    final _$actionInfo = _$_CreateadStoreActionController.startAction(
        name: '_CreateadStore.setDescription');
    try {
      return super.setDescription(value);
    } finally {
      _$_CreateadStoreActionController.endAction(_$actionInfo);
    }
  }

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
  void setPrice(String value) {
    final _$actionInfo = _$_CreateadStoreActionController.startAction(
        name: '_CreateadStore.setPrice');
    try {
      return super.setPrice(value);
    } finally {
      _$_CreateadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool? setHidePhone(bool? value) {
    final _$actionInfo = _$_CreateadStoreActionController.startAction(
        name: '_CreateadStore.setHidePhone');
    try {
      return super.setHidePhone(value);
    } finally {
      _$_CreateadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void invalidSendPressed() {
    final _$actionInfo = _$_CreateadStoreActionController.startAction(
        name: '_CreateadStore.invalidSendPressed');
    try {
      return super.invalidSendPressed();
    } finally {
      _$_CreateadStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
description: ${description},
category: ${category},
priceText: ${priceText},
hidePhone: ${hidePhone},
showErrors: ${showErrors},
loading: ${loading},
error: ${error},
savedAd: ${savedAd},
imagesValid: ${imagesValid},
titleValid: ${titleValid},
descValid: ${descValid},
categoryValid: ${categoryValid},
price: ${price},
address: ${address},
formValid: ${formValid},
sendPressed: ${sendPressed}
    ''';
  }
}
