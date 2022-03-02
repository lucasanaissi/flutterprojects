import 'package:admin_virtualstore/tabs/user_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController? _pageController;
  int _page = 0;


  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
          textTheme: Theme.of(context).textTheme.copyWith(
            caption: const TextStyle(
              color: Colors.white,
            )
          )
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.white,
          currentIndex: _page,
          onTap: (p) {
            _pageController?.animateToPage(
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
    );
  }
}
