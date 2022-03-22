import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:text_divider/text_divider.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/screens/signup/signup_screen.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import '../../stores/login_store.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  final LoginStore loginStore = LoginStore();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  bool visibility = true;


  @override
  void initState() {
    super.initState();

    when((_) => userManagerStore.user != null, () {
      Navigator.of(context).pop(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'Entrar',
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
                  thickness: 1,
                ),
                Observer(
                  builder: (_) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ErrorBox(
                        message: loginStore.error,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
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
                        child: Text(
                          'E-mail',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Observer(
                        builder: (_) {
                          return TextField(
                            enabled: !loginStore.loading,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                              errorText: loginStore.emailError,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: loginStore.setEmail,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 3, bottom: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            GestureDetector(
                              child: const Text(
                                'Esqueceu sua senha?',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Observer(
                        builder: (_) {
                          return TextField(
                            enabled: !loginStore.loading,
                            obscureText: visibility,
                            onChanged: loginStore.setPassword,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              isDense: true,
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
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Observer(
                        builder: (_) {
                          return SizedBox(
                            child: ElevatedButton(
                              onPressed: loginStore.loading
                                  ? null
                                  : loginStore.loginPressed,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(40),
                                primary: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              child: loginStore.loading
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
                                      'Entrar',
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
                          const Text('Não tem uma conta? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                            },
                            child: const Text(
                              'Cadastre-se!',
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
