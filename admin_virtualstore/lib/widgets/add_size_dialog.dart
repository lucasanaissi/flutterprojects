import 'package:flutter/material.dart';

class AddSizeDialog extends StatelessWidget {
  AddSizeDialog({Key? key}) : super(key: key);

  @override
  final _controller = TextEditingController();

  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Adicione o novo tamanho',
                labelStyle: TextStyle(
                  color: Colors.pinkAccent,
                ),
                suffixIcon: Icon(
                  Icons.add,
                  color: Colors.pinkAccent,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(_controller.text);
                },
                child: const Text(
                  '+ | Add',
                  style: TextStyle(
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
