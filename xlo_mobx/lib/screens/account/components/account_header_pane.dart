import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import '../../../models/user.dart';

class AccountHeaderPane extends StatelessWidget {
  AccountHeaderPane({Key? key}) : super(key: key);

  final UserManagerStore user = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.deepPurple,
      alignment: Alignment.center,
      child: Text(
        user.user!.name!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
