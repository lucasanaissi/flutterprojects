import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/product_screen.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot category;

  const CategoryTile({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          initiallyExpanded: false,
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              category.get('icon'),
            ),
            backgroundColor: Colors.transparent,
          ),
          title: Text(
            category.get('title'),
            style: TextStyle(
              color: Colors.grey[850],
              fontWeight: FontWeight.w500,
            ),
          ),
          children: [
            FutureBuilder<QuerySnapshot>(
                future: category.reference.collection('itens').get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    return Column(
                      children: snapshot.data!.docs.map((doc) {
                        return ListTile(
                          title: Text(
                            doc.get('title'),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(doc.get('images')[0]),
                            backgroundColor: Colors.transparent,
                          ),
                          trailing:
                              Text('R\$${doc.get('price').toStringAsFixed(2)}'),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ProductScreen(
                                    product: doc,
                                    categoryId: category.id,
                                  )),
                            );
                          },
                        );
                      }).toList()
                        ..add(
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.add,
                                color: Colors.pinkAccent,
                              ),
                            ),
                            title: const Text('Adicionar novo item'),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ProductScreen(
                                      categoryId: category.id,
                                    )),
                              );
                            },
                          ),
                        ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
