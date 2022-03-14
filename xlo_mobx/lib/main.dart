import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/generated/i18n.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/repositories/category_repository.dart';
import 'package:xlo_mobx/repositories/cep_repository.dart';
import 'package:xlo_mobx/repositories/ibge_repository.dart';
import 'package:xlo_mobx/screens/categories/categories_screen.dart';
import 'package:xlo_mobx/screens/home/home_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/stores/page_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import 'stores/category_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setupLocators();
  runApp(const MyApp());
}

void setupLocators() {
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(UserManagerStore());
  GetIt.I.registerSingleton(CategoryStore());
}

Future<void> initializeParse() async {
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
      theme: ThemeData(
          primaryColor: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            elevation: 0,
          )),
      home: const HomeScreen(),
    );
  }
}
