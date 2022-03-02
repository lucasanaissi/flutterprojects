import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanged;

  const InputField(
      {Key? key,
      required this.icon,
      required this.hint,
      required this.obscure,
      required this.stream,
      required this.onChanged}
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: stream,
        builder: (context, snapshot) {
          Object? _error = snapshot.hasError ? snapshot.error : '';

          return TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              icon: Icon(
                icon,
                color: Colors.white,
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.white,
              ),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.pinkAccent,
              )),
              contentPadding: const EdgeInsets.only(
                left: 5,
                right: 30,
                bottom: 30,
                top: 30,
              ),
              errorText: _error.toString(),
            ),
            style: const TextStyle(
              color: Colors.white,
            ),
            obscureText: obscure,
          );
        });
  }
}
