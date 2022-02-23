import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  TextComposer(this.sendMessage);

  final Function({String text, File imgFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController _controller = TextEditingController();
  bool _isComposing = false;

  final ImagePicker _picker = ImagePicker();

  void _reset() {
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[100],
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              XFile? imgFile =
              (await _picker.pickImage(source: ImageSource.camera));
              File imgFile1 = (File(imgFile!.path));
              if(imgFile == null) return;
              widget.sendMessage(imgFile: imgFile1);
            },
            icon: const Icon(
              Icons.photo_camera,
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(
                hintText: 'Envie sua mensagem.',
              ),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMessage(text: text, );
                _reset();
              },
            ),
          ),
          IconButton(
            onPressed: _isComposing
                ? () {
                    widget.sendMessage(text: _controller.text);
                    _reset();
                  }
                : null,
            icon: Icon(
              Icons.send,
              color: _isComposing ? Colors.blue : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
