import 'dart:async';

import 'package:admin_virtualstore/validators/login_validators.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

enum LoginState { IDLE, LOADING, SUCCESS, FAIL }

class LoginBloc extends BlocBase with LoginValidators {
  final _emailController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outEmail =>
      _emailController.stream.transform(validateEmail);

  Stream<String> get outPass => _passController.stream.transform(validatePass);

  Stream<LoginState> get outState => _stateController.stream;

  Stream<bool> get outSubmitValid =>
      Rx.combineLatest2(outEmail, outPass, (a, b) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePass => _passController.sink.add;

  StreamSubscription? _streamSubscription;

  LoginBloc() {
    FirebaseAuth.instance.signOut();

    _streamSubscription = FirebaseAuth.instance
        .authStateChanges()
        .listen((user) async {
      if (user != null) {
        if (await verifyPrivileges(user)) {
          _stateController.add(LoginState.SUCCESS);
        } else {
          _stateController.add(LoginState.FAIL);
          FirebaseAuth.instance.signOut();
        }
      } else {
        _stateController.add(LoginState.IDLE);
      }
     });
  }

  void submit() {
    final email = _emailController.value;
    final pass = _passController.value;
    _stateController.add(LoginState.LOADING);
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass)
        .catchError((e) {
      _stateController.add(LoginState.FAIL);
    });
  }

  Future<bool> verifyPrivileges(User user) async {
    return await FirebaseFirestore.instance
        .collection('admins')
        .doc(user.uid)
        .get()
        .then((doc) {
      if (doc.get('uid') != null) {
        return true;
      } else {
        return false;
      }
    }).catchError((e) {
      return false;
    });
  }

  @override
  void dispose() {
    _emailController.close();
    _passController.close();
    _stateController.close();
    _streamSubscription?.cancel();
    super.dispose();
  }
}
