import 'package:flutter/material.dart';

class PriceField extends StatelessWidget {
  const PriceField({Key? key, this.text}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: text,
          labelText: text,
          isDense: true,
        ),
        keyboardType: const TextInputType.numberWithOptions(),
      ),
    );
  }
}
