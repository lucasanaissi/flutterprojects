import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/screens/account_data/components/change_password_page.dart';
import 'package:xlo_mobx/stores/edit_account_store.dart';

import '../../stores/page_store.dart';

class AccountDataScreen extends StatelessWidget {
  AccountDataScreen({Key? key}) : super(key: key);

  final EditAccountStore store = EditAccountStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Dados da conta',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Card(
              elevation: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dados da conta',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Nome completo',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Observer(
                      builder: (_) {
                        return TextFormField(
                          initialValue: store.name,
                          enabled: !store.loading,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              isDense: true,
                              errorText: store.nameError),
                          onChanged: store.setName,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Text(
                          'Telefone',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Observer(builder: (_) {
                      return TextFormField(
                        initialValue: store.phone,
                        enabled: !store.loading,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          isDense: true,
                          errorText: store.phoneError,
                        ),
                        onChanged: store.setPhone,
                      );
                    }),
                    const SizedBox(height: 15),
                    const Text(
                      'E-mail',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Observer(builder: (_) {
                      return TextFormField(
                        initialValue: store.email,
                        enabled: !store.loading,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: store.emailError),
                        onChanged: store.setEmail,
                      );
                    }),
                    const SizedBox(height: 15),
                    RichText(
                      text: TextSpan(
                          text: 'Tipo de conta',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: store.userType! == UserType.PARTICULAR
                                  ? '   Particular'
                                  : '   Profissional',
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ]),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Observer(builder: (_) {
                        return ElevatedButton(
                          onPressed: store.saveFormPressed,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(40),
                            primary: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: store.loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.orange,
                                    ),
                                    strokeWidth: 1.0,
                                  ),
                                )
                              : const Text(
                                  'Salvar alterações',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 1,
              child: Observer(
                builder: (_) {
                  return !store.loading
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) =>
                                    ChangePasswordPage(store: store)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Alterar senha',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.deepPurple,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Alterar senha',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.grey),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.grey,
                                size: 15,
                              ),
                            ],
                          ),
                        );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Observer(
                  builder: (_) {
                    return ElevatedButton.icon(
                      onPressed: store.loading
                          ? null
                          : () {
                              store.logout();
                              GetIt.I<PageStore>().setPage(0);
                              Navigator.of(context).pop();
                            },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      icon: const Icon(
                        Icons.logout,
                        size: 15,
                      ),
                      label: const Text(
                        'Sair',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
