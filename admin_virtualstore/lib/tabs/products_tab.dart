import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/category_tile.dart';

class ProductsTab extends StatefulWidget {
  const ProductsTab({Key? key}) : super(key: key);

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('products').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Colors.white,
              ),
            ),
          );
        } else {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return CategoryTile(
                  category: snapshot.data!.docs[index]
                );
              }
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}