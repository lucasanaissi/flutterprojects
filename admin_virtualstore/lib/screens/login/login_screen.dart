import 'package:admin_virtualstore/blocs/login_bloc.dart';
import 'package:flutter/material.dart';

import '../../widgets/input_field.dart';
import '../home/home_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen(
            (state) {
          switch (state) {
            case LoginState.SUCCESS:
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen())
              );
              break;
            case LoginState.FAIL:
              showDialog(context: context, builder: (context) =>
              const AlertDialog(
                title: Text('Erro'),
                content: Text('Você não possui os privilégios necessários.'),
              ));
              break;
            case LoginState.LOADING:
            case LoginState.IDLE:
              break;
          }
        }
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<LoginState>(
          stream: _loginBloc.outState,
          initialData: LoginState.LOADING,
          builder: (context, snapshot) {
            print(snapshot.data);
            switch (snapshot.data) {
              case LoginState.LOADING:
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                        Colors.pinkAccent),
                  ),
                );
                break;
              case LoginState.SUCCESS:
              case LoginState.FAIL:
              case LoginState.IDLE:
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(),
                    SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Icon(
                              Icons.store_mall_directory,
                              color: Colors.pinkAccent,
                              size: 160,
                            ),
                            InputField(
                              icon: Icons.person_outline,
                              hint: 'E-mail',
                              obscure: false,
                              onChanged: _loginBloc.changeEmail,
                              stream: _loginBloc.outEmail,
                            ),
                            InputField(
                              icon: Icons.password,
                              hint: 'Password',
                              obscure: true,
                              onChanged: _loginBloc.changePass,
                              stream: _loginBloc.outPass,
                            ),
                            const SizedBox(height: 32),
                            StreamBuilder<bool>(
                                stream: _loginBloc.outSubmitValid,
                                builder: (context, snapshot) {
                                  return SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: snapshot.hasData
                                          ? _loginBloc.submit
                                          : null,
                                      child: const Text(
                                        'Login',
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            Colors.pinkAccent),
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
                break;
              case null:
                return Container();
                break;
            }
          }),
    );
  }
}
