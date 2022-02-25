import 'package:animations/screens/login/widgets/form_container.dart';
import 'package:animations/screens/login/widgets/sign_up_button.dart';
import 'package:animations/screens/login/widgets/stagger_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {

  AnimationController? _animationController;


  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),

    );
  }


  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/background.jpg',
            ),
            fit: BoxFit.cover,
          )
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:70, bottom: 32),
                      child: Image.asset(
                        'assets/tickicon1.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                        color: Colors.white,
                      ),
                    ),
                    const FormContainer(),
                    const SignUpButton(),
                  ],
                ),
                StaggerAnimation(
                  controller: _animationController!.view as AnimationController,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
