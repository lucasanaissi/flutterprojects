import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class UserModel extends Model {
  // Usuário atual

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? firebaseUser;
  Map<String, dynamic> userData = {};

  bool isLoading = false;

  static UserModel of(BuildContext context) => ScopedModel.of<UserModel>(context);


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  void signUp(
      {required Map<String, dynamic> userData,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: userData['email'], password: pass);

      firebaseUser = result.user!;
      await _saveUserData(userData);
      onSuccess();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Deu erro $e');
      onFail();
      isLoading = false;
      notifyListeners();
    }
  }

  void signIn(
      {required String email,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: pass);
      firebaseUser = result.user!;

      await _loadCurrentUser();

      onSuccess();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      onFail();
      isLoading = false;
      notifyListeners();
    }

  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid)
        .set(userData);
  }

  void signOut() async {
    await _auth.signOut();
    userData = {};
    firebaseUser = null;

    notifyListeners();
  }

  Future<void> _loadCurrentUser () async {

    if (firebaseUser == null) {
      firebaseUser = await _auth.currentUser;
    }

    if (firebaseUser != null) {
      if(userData['name'] == null){
        DocumentSnapshot docUser = await
        FirebaseFirestore
            .instance
            .collection('users')
            .doc(firebaseUser!.uid)
            .get();
        userData = docUser.data() as Map<String, dynamic>;
      }
    }
    notifyListeners();
  }

}
