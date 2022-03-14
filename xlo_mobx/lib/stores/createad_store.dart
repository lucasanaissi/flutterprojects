import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/stores/cep_store.dart';

import '../models/address.dart';
import '../models/category.dart';

part 'createad_store.g.dart';

class CreateadStore = _CreateadStore with _$CreateadStore;

abstract class _CreateadStore with Store {
  ObservableList images = ObservableList();

  @computed
  bool get imagesValid => images.isNotEmpty;

  String? get imagesError {
    if (!showErrors || imagesValid) {
      return null;
    } else {
      return 'Insira imagens';
    }
  }

  @observable
  String? title = '';

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title!.length >= 6;

  String? get titleError {
    if (!showErrors || titleValid) {
      return null;
    } else if (title!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Título muito curto';
    }
  }

  @observable
  String? description = '';

  @action
  void setDescription(String value) => description = value;

  @computed
  bool get descValid => description!.length >= 10;

  String? get descError {
    if (!showErrors || descValid) {
      return null;
    } else if (description!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Descrição muito curta';
    }
  }

  @observable
  Category? category;

  @action
  void setCategory(Category value) => category = value;

  @computed
  bool get categoryValid => category != null;
  String? get categoryError {
    if (!showErrors || categoryValid) {
      return null;
    } else {
      return 'Campo obrigatório';
    }
  }

  @observable
  String? priceText = '';

  @action
  void setPrice(String value) => priceText = value;
  
  @computed
  num? get price {
    if(priceText!.contains('.')) {
      return num.tryParse(
          priceText!.replaceAll(RegExp('[^0-9]'), ''))! / 100;
    } else {
      return num.tryParse(priceText!);
    }
  }
  bool get priceValid => price != null && price! <= 9999999;
  String? get priceError {
    if (!showErrors || priceValid) {
      return null;
    } else if(priceText!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Preço inválido';
    }
  }

  CepStore cepStore = CepStore();

  @computed
  Address? get address => cepStore.address;
  bool get addressValid => address != null;
  String? get addressError {
    if (!showErrors || addressValid) {
      return null;
    } else {
      return 'Campo obrigatório';
    }
  }

  @observable
  bool? hidePhone = false;

  @action
  bool? setHidePhone(bool? value) => hidePhone = value;


  @computed
  bool get formValid => imagesValid
      && titleValid
      && descValid
      && categoryValid
      && addressValid
      && priceValid;

  @computed
  dynamic get sendPressed => formValid ? _send : null;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  void _send() {

  }

}
