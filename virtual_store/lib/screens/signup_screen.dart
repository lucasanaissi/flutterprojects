import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/user_model.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passController = TextEditingController();
    final _addressController = TextEditingController();

    final _formKey = GlobalKey<FormState>();


    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Criar conta',
        ),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        hintText: 'Nome completo'
                    ),
                    validator: (text) {
                      if (text!.isEmpty) return "Nome inválido.";
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        hintText: 'E-mail'
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text!.isEmpty || !text.contains("@") ||
                          !text.contains('.'))
                        return "E-mail inválido.";
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passController,
                    decoration: const InputDecoration(
                        hintText: 'Senha'
                    ),
                    obscureText: true,
                    validator: (text) {
                      if (text!.isEmpty || text.length < 8)
                        return "Senha inválida. (8 digitos)";
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                        hintText: 'Endereço'
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Endereço inválido.";
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> userData = {
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'address': _addressController.text,
                        };

                        model.signUp(
                            userData: userData,
                            pass: _passController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail
                        );
                      }
                    },
                    child: const Text(
                      'Criar conta',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }

    void _onSuccess() {
      _scaffoldKey.currentState?.showSnackBar(
        const SnackBar(
            content: Text(
              'Usuário criado com sucesso',
            ),
          backgroundColor: Colors.purple,
          duration: Duration(seconds: 2),
        )
      );
      Future.delayed(const Duration(seconds: 2)).then((_) {
        Navigator.of(context).pop();
      });
    }

    void _onFail() {
      _scaffoldKey.currentState?.showSnackBar(
          const SnackBar(
            content: Text(
              'Falha ao criar o usuário',
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          )
      );
    }
  }