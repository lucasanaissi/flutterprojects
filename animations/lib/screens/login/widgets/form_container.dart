import 'package:flutter/material.dart';

import 'input_field.dart';

class FormContainer extends StatelessWidget {
  const FormContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        child: Column(
          children: const [
            InputField(
              icon: Icons.person_outline,
              obscure: false,
              hint: 'Username',
            ),
            InputField(
              icon: Icons.lock_outline,
              obscure: true,
              hint: 'Password',
            ),
          ],
        ),
      ),
    );
  }
}
