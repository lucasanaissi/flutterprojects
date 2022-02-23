import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:currency_converter/pages/converter_home.dart';

const request = "https://api.hgbrasil.com/finance?key=17fc96b6";

void main() async {
  runApp(MyApp());
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder:
            OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white,
                ),
            ),
            focusedBorder:
            OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.amber,
                ),
            ),
            hintStyle: TextStyle(
                color: Colors.amber,
            ),
          ),
      ),
    );
  }
}
