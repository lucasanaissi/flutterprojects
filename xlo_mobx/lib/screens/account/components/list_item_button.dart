import 'package:flutter/material.dart';

class ListItemButton extends StatelessWidget {
  const ListItemButton({Key? key, required this.message, required this.onTap})
      : super(key: key);

  final String message;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.centerLeft,
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
