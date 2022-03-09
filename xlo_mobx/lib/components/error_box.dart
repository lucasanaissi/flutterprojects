import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  final String? message;

  const ErrorBox({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message == null) {
      return Container();
    } else {
      return Container(
        color: Colors.red,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  children: [
                    const TextSpan(text: 'Opss. '),
                    TextSpan(
                      text: 'Erro: $message.',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: ' Tente novamente.'
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
