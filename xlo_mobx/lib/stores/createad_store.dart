import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import '../models/ad.dart';
import '../models/address.dart';
import '../models/category.dart';

part 'createad_store.g.dart';

class CreateadStore = _CreateadStore with _$CreateadStore;

abstract class _CreateadStore with Store {
  _CreateadStore({this.ad}) {
    if (ad != null) {
      title = ad!.title;
      description = ad!.description;
      images = ad!.images!.asObservable();
      category = ad!.category;
      priceText = ad!.price.formattedMoney();
      hidePhone = ad!.hidePhone;
    }
    if (ad?.address != null) {
      cepStore = CepStore(ad!.address!.cep);
    } else {
      cepStore = CepStore(null);
    }
  }

  final Ad? ad;

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
    if (priceText!.contains('.')) {
      return num.tryParse(priceText!.replaceAll(RegExp('[^0-9]'), ''))! / 100;
    } else {
      return num.tryParse(priceText!);
    }
  }

  bool get priceValid => price != null && price! <= 9999999;

  String? get priceError {
    if (!showErrors || priceValid) {
      return null;
    } else if (priceText!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Preço inválido';
    }
  }

  late CepStore cepStore;

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
  bool get formValid =>
      imagesValid &&
          titleValid &&
          descValid &&
          categoryValid &&
          addressValid &&
          priceValid;

  @computed
  dynamic get sendPressed => formValid ? _send : null;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  bool loading = false;

  @observable
  String? error;

  @observable
  bool savedAd = false;

  @action
  Future<void> _send() async {
    Ad newAd = Ad();
    if (ad != null) {
      ad!.title = title;
      ad!.description = description;
      ad!.category = category;
      ad!.price = price!;
      ad!.hidePhone = hidePhone!;
      ad!.images = images;
      ad!.address = address;
      ad!.user = GetIt
          .I<UserManagerStore>()
          .user!;
    } else {
      newAd.title = title;
      newAd.description = description;
      newAd.category = category;
      newAd.price = price!;
      newAd.hidePhone = hidePhone!;
      newAd.images = images;
      newAd.address = address;
      newAd.user = GetIt
          .I<UserManagerStore>()
          .user!;
    }

    loading = true;
    try {
      await AdRepository().save(ad != null? ad! : newAd);
      savedAd = true;
    } catch (e) {
      error = e.toString();
    }
    loading = false;
  }
}
