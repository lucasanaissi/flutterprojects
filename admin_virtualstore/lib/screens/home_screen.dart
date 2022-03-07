import 'package:admin_virtualstore/blocs/users_bloc.dart';
import 'package:admin_virtualstore/tabs/products_tab.dart';
import 'package:admin_virtualstore/tabs/user_tab.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../blocs/orders_bloc.dart';
import '../tabs/orders_tab.dart';
import '../widgets/edit_category_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late PageController _pageController;
  int _page = 0;

  late UserBloc _userBloc;
  late OrdersBloc _ordersBloc;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _userBloc = UserBloc();
    _ordersBloc = OrdersBloc();
    _ordersBloc.setOrderCriteria(SortCriteria.READY_FIRST);
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
            Bloc((i) => _userBloc),
            Bloc((i) => _ordersBloc),
          ],
          child: PageView(
            controller: _pageController,
            onPageChanged: (p) {
              setState(() {
                _page = p;
              });
            },
            children: const [
              UsersTab(),
              OrdersTab(),
              ProductsTab(),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloating(),
    );
  }

  Widget? _buildFloating() {
    switch (_page) {
      case 0:
        return null;
      case 1:
        return SpeedDial(
          child: const Icon(
            Icons.sort,
          ),
          backgroundColor: Colors.pinkAccent,
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
              child: const Icon(
                Icons.arrow_downward,
              ),
              backgroundColor: Colors.white,
              label: 'Concluídos abaixo',
              labelStyle: const TextStyle(
                fontSize: 14,
              ),
              onTap: () {
                _ordersBloc.setOrderCriteria(SortCriteria.READY_LAST);
              },
            ),
            SpeedDialChild(
              child: const Icon(
                Icons.arrow_upward,
              ),
              backgroundColor: Colors.white,
              label: 'Concluídos acima',
              labelStyle: const TextStyle(
                fontSize: 14,
              ),
              onTap: () {
                _ordersBloc.setOrderCriteria(SortCriteria.READY_FIRST);
              },
            )
          ],
        );
      case 2:
        return FloatingActionButton(
          child: const Icon(
            Icons.add
          ),
          backgroundColor: Colors.pinkAccent,
          onPressed: (){
            showDialog(
              context: context,
              builder: (context) => EditCategoryDialog(),
            );
          },
        );
    }
    return null;
  }
}