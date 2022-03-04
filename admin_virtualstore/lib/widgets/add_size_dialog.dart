import 'package:flutter/material.dart';

class AddSizeDialog extends StatelessWidget {
  const AddSizeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             const TextField(
              decoration: InputDecoration(
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
                  )
                )
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
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
