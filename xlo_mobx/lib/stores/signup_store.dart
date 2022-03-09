import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import '../models/user.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store {
  @observable
  String? name;

  @action
  void setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name!.length > 6;

  String? get nameError {
    if (name == null || nameValid) {
      return null;
    } else if (name!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Nome muito curto';
    }
  }

  @observable
  String? email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email!.isEmailValid();

  String? get emailError {
    if (email == null || emailValid) {
      return null;
    } else if (email!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'E-mail inválido';
    }
  }

  @observable
  String? phone;

  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone!.length >= 11;

  String? get phoneError {
    if (phone == null || phoneValid) {
      return null;
    } else if (phone!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Telefone inválido';
    }
  }

  @observable
  String? password;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password != null && password!.isPassValid();
  String? get passwordError {
    if (password == null || passwordValid) {
      return null;
    } else if (password!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Senha inválida.';
    }
  }

  @observable
  String? password2;

  @action
  void setPassword2(String value) => password2 = value;

  @computed
  bool get password2Valid => password2 != null && password2 == password;
  String? get password2Error {
    if (password2 == null || password2Valid) {
      return null;
    } else {
      return 'Senhas não coincidem.';
    }
  }

  @computed
  bool get isFormValid => nameValid && emailValid
      && phoneValid && password2Valid && passwordValid;


  @computed
  dynamic get signUpPressed => (isFormValid && !loading!) ? _signUp : null;

  @observable
  bool? loading = false;

  @observable
  String? error;


  @action
  Future<void> _signUp () async {
    loading = true;

    final user = User(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );

    try {
      final resultUser = await UserRepository().signUp(user);
      GetIt.I<UserManagerStore>().setUser(resultUser);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
  }

}
