import 'package:animations/screens/home/home_screen.dart';
import 'package:animations/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animations intro',
      home: HomeScreen(),
    );
  }
}

