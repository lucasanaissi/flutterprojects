import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/screens/signup_screen.dart';

import '../models/user_model.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    void _onSuccess() {
      Navigator.of(context).pop();
    }

    void _onFail() {
      _scaffoldKey.currentState?.showSnackBar(
          const SnackBar(
            content: Text(
              'Falha ao realizar login',
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          )
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Entrar',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const SignUpScreen()));
            },
            icon: const Icon(Icons.person_add),
            color: Colors.white,
          ),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
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
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (text) {
                  if (text!.isEmpty ||
                      !text.contains("@") ||
                      !text.contains('.')) return "E-mail inválido.";
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passController,
                decoration: const InputDecoration(hintText: 'Senha'),
                obscureText: true,
                validator: (text) {
                  if (text!.isEmpty || text.length < 8)
                    return "Senha inválida. (8 digitos)";
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    if(_emailController.text.isEmpty){
                      _scaffoldKey.currentState?.showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Insira seu e-mail',
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          )
                      );
                    } else {
                      model.recoverPass(_emailController.text);
                      _scaffoldKey.currentState?.showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Confira seu e-mail',
                            ),
                            backgroundColor: Colors.purple,
                            duration: Duration(seconds: 2),
                          )
                      );
                    }
                  },
                  child: const Text(
                    'Esqueci minha senha',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                  model.signIn(
                    email: _emailController.text,
                    pass: _passController.text,
                    onSuccess: _onSuccess,
                    onFail: _onFail,
                  );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
