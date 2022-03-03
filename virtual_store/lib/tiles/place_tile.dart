import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  const PlaceTile(this.snapshot, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100,
            child: Image.network(
              snapshot.get('image'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot.get('title'),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),Text(
                  snapshot.get('address'),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: (){
                    launch("https://www.google.com/maps/search?api=&query${snapshot.get('lat')},${snapshot.get('long')}");
                  },
                  icon: const Icon(
                    Icons.share_location,
                    color: Colors.purple,
                  )
              ),
              IconButton(
                  onPressed: (){
                    launch("tel: ${snapshot.get('phone')}");
                  },
                  icon: const Icon(
                      Icons.phone,
                    color: Colors.purple,
                  ))
            ],
          )
        ],
      ),
    );

  }
}
