import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/generated/i18n.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  runApp(const MyApp());

  await Parse().initialize(
    'tlNz6KD2FEOxfdBKapqn8N58zv0ohzZUAt1N1XJU',
    'https://parseapi.back4app.com/',
    clientKey: 'bO6j9VnlJbmiKvfI9mFtt7wBeeGuOkCNgWbJEfsj',
    autoSendSessionId: true,
    debug: true,
  );


}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(),
    );
  }
}
