import 'package:flutter/material.dart';

import 'home_top.dart';

class StaggerAnimation extends StatelessWidget {
  final AnimationController controller;

   StaggerAnimation({required this.controller, Key? key})
      : containerGrow = CurvedAnimation(
      parent: controller,
      curve: Curves.ease
  );

  final Animation<double> containerGrow;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [HomeTop(containerGrow: containerGrow)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AnimatedBuilder(
          animation: controller,
          builder: _buildAnimation,
        ),
      ),
    );
  }
}
