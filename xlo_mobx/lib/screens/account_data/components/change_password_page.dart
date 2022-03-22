import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/edit_account_store.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key, required this.store}) : super(key: key);

  final EditAccountStore store;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Nova senha',
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.password,
                  size: 70,
                  color: Colors.deepPurple,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Altere sua senha',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Crie uma senha longa e complexa, com letras maíusculas, minúsculas, números e símbolos',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Nova senha',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                Observer(builder: (_) {
                  return TextFormField(
                    enabled: !store.loading,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    obscureText: true,
                    onChanged: store.setPass1,
                  );
                }),
                const SizedBox(height: 10),
                const Text(
                  'Confirme a nova senha',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                Observer(builder: (_) {
                  return TextFormField(
                    enabled: !store.loading,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      isDense: true,
                      errorText: store.passError,
                    ),
                    obscureText: true,
                    onChanged: store.setPass2,
                  );
                }),
                const SizedBox(height: 15),
                Observer(builder: (_) {
                  return ElevatedButton(
                    onPressed: store.changePassPressed,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: const Text(
                      'Enviar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
