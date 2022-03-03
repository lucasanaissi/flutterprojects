import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() {
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

    CollectionReference _home = FirebaseFirestore.instance.collection('home');

    return Stack(
      children: [
        _buildBodyBack(),
        CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Novidades',
                ),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: _home.orderBy('pos', descending: false).get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                } else {
                  return SliverStaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    staggeredTiles: snapshot.data!.docs.map((doc) {
                      final docMap = doc.data() as Map<String, dynamic>;

                      return StaggeredTile.count(
                        docMap['x'],
                        docMap['y'].toDouble(),
                      );
                    }).toList(),
                    children: snapshot.data!.docs.map(
                      (doc) {
                        final docMap = doc.data() as Map<String, dynamic>;
                        return FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: docMap['image'],
                          fit: BoxFit.cover,
                        );
                      },
                    ).toList(),
                  );
                }
              },
            )
          ],
        )
      ],
    );
  }
}
