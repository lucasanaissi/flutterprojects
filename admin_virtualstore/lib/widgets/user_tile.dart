import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserTile extends StatelessWidget {

  final Map<String, dynamic> user;

  const UserTile({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    if (user.containsKey('money')){
      return ListTile(
        title: Text(
          user['name'],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          user['email'],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Pedidos: ${user['orders']}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              'Gasto: R\$${user['money'].toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              height: 20,
              child: Shimmer.fromColors(
                highlightColor: Colors.grey,
                baseColor: Colors.white,
                child: Container(
                  color: Colors.white.withAlpha(50),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                ),
              ),
            ),
            SizedBox(
              width: 50,
              height: 20,
              child: Shimmer.fromColors(
                highlightColor: Colors.grey,
                baseColor: Colors.white,
                child: Container(
                  color: Colors.white.withAlpha(50),
                  margin: const EdgeInsets.symmetric(vertical: 4),

                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
