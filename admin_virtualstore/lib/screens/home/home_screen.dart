import 'package:admin_virtualstore/blocs/user_bloc.dart';
import 'package:admin_virtualstore/tabs/user_tab.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late PageController _pageController;
  int _page = 0;

  late UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _userBloc = UserBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            canvasColor: Colors.pinkAccent,
            primaryColor: Colors.white,
            textTheme: Theme
                .of(context)
                .textTheme
                .copyWith(
                caption: const TextStyle(
                  color: Colors.white,
                )
            )
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.white,
          currentIndex: _page,
          onTap: (p) {
            _pageController.animateToPage(
              p,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.person
              ),
              label: 'Clientes',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                    Icons.shopping_cart
                ),
                label: 'Pedidos'
            ),
            BottomNavigationBarItem(
                icon: Icon(
                    Icons.list
                ),
                label: 'Produtos'
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: BlocProvider(
          dependencies: const [],
          blocs: [
            Bloc((i) => _userBloc)
          ],
          child: PageView(
            controller: _pageController,
            onPageChanged: (p) {
              setState(() {
                _page = p;
              });
            },
            children: [
              const UsersTab(),
              Container(color: Colors.blue),
              Container(color: Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}
