import 'package:admin_virtualstore/blocs/user_bloc.dart';
import 'package:admin_virtualstore/screens/login/login_screen.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      dependencies: const [],
      blocs: [
        Bloc((i) => UserBloc())
      ],
      child: MaterialApp(
        home: const Home(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.pinkAccent
        ),
      ),
    );
  }
}
