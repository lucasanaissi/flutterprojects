import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:text_divider/text_divider.dart';
import 'package:xlo_mobx/screens/login/login_screen.dart';
import 'package:xlo_mobx/stores/signup_store.dart';

import '../../components/error_box.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignupStore signUpStore = SignupStore();

  bool visibility = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'Cadastro',
          ),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Observer(
                  builder: (_) {
                    return ErrorBox(
                      message: signUpStore.error,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  child: SizedBox(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        primary: const Color.fromRGBO(59, 89, 152, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.facebook,
                          ),
                          SizedBox(width: 60),
                          Text(
                            'Entrar com o Facebook',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: SizedBox(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        primary: const Color.fromRGBO(66, 133, 244, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.facebook,
                          ),
                          SizedBox(width: 70),
                          Text(
                            'Entrar com o Google',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const TextDivider(
                    text: Text(
                      'ou',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    color: Colors.grey,
                    thickness: 1),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                          bottom: 4,
                          top: 8,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Apelido',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '  Como aparecer?? em seus an??ncios',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Observer(
                        builder: (BuildContext context) {
                          return TextField(
                            enabled: !signUpStore.loading!,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                isDense: true,
                                errorText: signUpStore.nameError,
                                hintText: 'Exemplo: Jo??o S.'),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: signUpStore.setName,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                          bottom: 4,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Celular',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '  Proteja sua conta.',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Observer(builder: (_) {
                        return TextField(
                          enabled: !signUpStore.loading!,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            hintText: '(99) 99999-9999',
                            errorText: signUpStore.phoneError,
                          ),
                          keyboardType: TextInputType.phone,
                          autocorrect: false,
                          onChanged: signUpStore.setPhone,
                        );
                      }),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                          bottom: 4,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'E-mail',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '  Enviaremos um e-mail de confirma????o.',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Observer(
                        builder: (_) {
                          return TextField(
                            enabled: !signUpStore.loading!,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              isDense: true,
                              hintText: 'nome@email.com',
                              errorText: signUpStore.emailError,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            onChanged: signUpStore.setEmail,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 3, bottom: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Senha',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '  Use letras (uma delas maiuscula), n??meros e um @.',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Observer(
                        builder: (_) {
                          return TextField(
                            enabled: !signUpStore.loading!,
                            obscureText: visibility,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              isDense: true,
                              errorText: signUpStore.passwordError,
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    visibility = !visibility;
                                  });
                                },
                                child: Icon(
                                  visibility
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            onChanged: signUpStore.setPassword,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 3, bottom: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Confirmar Senha',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '  Repita a senha.',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Observer(
                        builder: (_) {
                          return TextField(
                            enabled: !signUpStore.loading!,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              isDense: true,
                              errorText: signUpStore.password2Error,
                            ),
                            onChanged: signUpStore.setPassword2,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Observer(
                        builder: (_) {
                          return SizedBox(
                            child: ElevatedButton(
                              onPressed: signUpStore.signUpPressed,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(40),
                                primary: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              child: signUpStore.loading!
                                  ? const SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                        strokeWidth: 1.0,
                                      ),
                                    )
                                  : const Text(
                                      'Cadastre-se',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('J?? tem uma conta? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                            },
                            child: const Text(
                              'Entrar',
                              style: TextStyle(
                                color: Colors.purple,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
