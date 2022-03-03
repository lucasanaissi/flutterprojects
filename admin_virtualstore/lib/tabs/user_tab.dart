import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../blocs/user_bloc.dart';
import '../widgets/user_tile.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _usersBloc = BlocProvider.getBloc<UserBloc>();

    return Column(
      children: [
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            decoration: const InputDecoration(
                hintText: 'Pesquisar',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                border: InputBorder.none),
            style: const TextStyle(
              color: Colors.white,
            ),
            onChanged: _usersBloc.onChangedSearch,
          ),
        ),
        Expanded(
          child: StreamBuilder<List>(
              stream: _usersBloc.outUsers,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                    ),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum usuário encontrado.',
                      style: TextStyle(
                        color: Colors.pinkAccent,
                      ),
                    ),
                  );
                } else {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return UserTile(
                          user: snapshot.data![index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: snapshot.data!.length,
                  );
                }
              }),
        )
      ],
    );
  }
}
