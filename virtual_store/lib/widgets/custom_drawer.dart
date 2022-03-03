import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/models/user_model.dart';
import 'package:virtual_store/screens/login_screen.dart';

import '../tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  const CustomDrawer(this.pageController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() {
      return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              stops: [
                0.22,
                0.76,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF729fcf),
                Color(0xFF6da9ba),
              ],
            )
        ),
      );
    }

    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: const EdgeInsets.only(left: 32, top: 16),
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: [
                    const Positioned(
                      top: 8,
                      left: 0,
                      child: Text(
                        'Flutter\'s\nClothing',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Olá, ${!model.isLoggedIn() ?
                                    "" :
                                    model.userData['name']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    child: Text(
                                      !model.isLoggedIn() ?
                                      'Entre ou cadastre-se >'
                                      : 'Sair',
                                      style: const TextStyle(
                                        color: Colors.purple,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onTap: () {
                                      if (!model.isLoggedIn()) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                LoginScreen())
                                        );
                                      } else {
                                        model.signOut();
                                      }
                                    },
                                  ),
                                ]
                            );
                          },
                        )
                    ),
                  ],
                ),
              ),
              const Divider(),
              DrawerTile(Icons.home, 'Inicio', pageController, 0),
              DrawerTile(Icons.list, 'Produtos', pageController, 1),
              DrawerTile(Icons.location_on_sharp, 'Lojas', pageController, 2),
              DrawerTile(
                  Icons.playlist_add_check, 'Meus pedidos', pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}
