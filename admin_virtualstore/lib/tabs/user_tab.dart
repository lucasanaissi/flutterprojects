import 'package:flutter/material.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Pesquisar',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              border: InputBorder.none
            ),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'demp'
                    //TODO: UserTile!
                    //UserTile();
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: 5,
          ),
        )
      ],
    );
  }
}
