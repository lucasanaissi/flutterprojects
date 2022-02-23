import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(this.data, this.mine);

  final Map<String, dynamic> data;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          !mine ?
          CircleAvatar(
            backgroundImage: NetworkImage(
                data['senderPhotoUrl']
            ),
          ) : Container(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  data['imgUrl'] != null
                      ? Image.network(
                          data['imgUrl'],
                          width: 250,
                        )
                      : Text(
                          data['text'],
                          textAlign: mine ? TextAlign.end : TextAlign.start,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                  Text(
                    data['senderName'],
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          mine ?
          CircleAvatar(
            backgroundImage: NetworkImage(
                data['senderPhotoUrl']
            ),
          ) : Container(),
        ],
      ),
    );
  }
}
