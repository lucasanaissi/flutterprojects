import 'package:flutter/material.dart';

class PriceField extends StatelessWidget {
  const PriceField({Key? key,
    required this.text,
    required this.onChanged,
    required this.initialValue,
  })
      : super(key: key);

  final String text;
  final Function(int) onChanged;
  final int? initialValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        initialValue: initialValue?.toString(),
        keyboardType: const TextInputType.numberWithOptions(),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: text,
          labelText: text,
          isDense: true,
        ),
        onChanged: (text) {
          onChanged(int.tryParse(text.replaceAll('.', ''))!);
        },
      ),
    );
  }
}
