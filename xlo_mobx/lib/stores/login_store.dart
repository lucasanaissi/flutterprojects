import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String? email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email!.isEmailValid();

  String? get emailError =>
      email == null || emailValid ? null : 'E-mail válido';

  @observable
  String? password;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password != null && password!.isPassValid();

  String? get passwordError =>
      password == null || passwordValid ? null : 'Senha inválida';

  @computed
  dynamic get loginPressed => emailValid && passwordValid ? _signIn : null;

  @observable
  bool loading = false;

  @observable
  String? error;

  @action
  Future<void> _signIn() async {
    loading = true;

    try {
      final user = await UserRepository().loginWithEmail(
        email!,
        password!,
      );
      GetIt.I<UserManagerStore>().setUser(user);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
  }
}
