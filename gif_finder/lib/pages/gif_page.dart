import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

class GifPage extends StatelessWidget {

  final Map _gifData;

  GifPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _gifData["title"],
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(
                Icons.share),
            onPressed: () {
              FlutterShare.share(
                  title: _gifData["title"],
                  text: _gifData["images"]["fixed_height"]["url"],
              );
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_gifData["images"]["fixed_height"]["url"]),
      ),
    );
  }
}
