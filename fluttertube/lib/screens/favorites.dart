import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../blocs/favorite_bloc.dart';
import '../models/video.dart';

class Favorites extends StatelessWidget {

  Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Favoritos'
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFav,
        initialData: {},
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data!.values.map(
                    (v) {
                  return InkWell(
                    onTap: () {
                    },
                    onLongPress: () {
                      bloc.toggleFavorite(v);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: Image.network(
                            v.thumb!,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            v.title!,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  );
                }
            ).toList(),
          );
        },
      ),
    );
  }
}
