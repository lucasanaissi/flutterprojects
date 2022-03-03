import 'package:admin_virtualstore/blocs/users_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderHeaderButton extends StatelessWidget {

  final DocumentSnapshot<Object?> order;

  const OrderHeaderButton({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userBloc = BlocProvider.getBloc<UserBloc>();
    final _user = _userBloc.getUser(order.get('clientId'));

    return TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Informações do usuário',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${_user['name']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('${_user['email']}'),
                      Text('${_user['address']}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Fechar',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ))
                  ],
                );
              });
        },
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.pinkAccent,
          onSurface: Colors.grey,
        ),
        child: const Text(
          'Informações do cliente',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ));
  }
}
