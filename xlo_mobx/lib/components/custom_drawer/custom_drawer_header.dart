import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';

import '../../screens/login/login_screen.dart';
import '../../stores/page_store.dart';
import '../../stores/user_manager_store.dart';

class CustomDrawerHeader extends StatelessWidget {
  CustomDrawerHeader({Key? key}) : super(key: key);

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();

        if (userManagerStore.isLoggedIn) {
          GetIt.I<PageStore>().setPage(5);
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      },
      child: Container(
        height: 90,
        color: Colors.deepPurple,
        child: Padding(
          padding: const EdgeInsets.only(left: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                color: Colors.white,
                size: 50,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userManagerStore.isLoggedIn
                          ? userManagerStore.user!.name!
                          : 'Acesse sua conta agora!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      userManagerStore.isLoggedIn
                          ? userManagerStore.user!.email!
                          : 'Clique aqui',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
