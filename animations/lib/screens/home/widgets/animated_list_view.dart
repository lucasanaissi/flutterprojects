import 'package:flutter/material.dart';

import 'list_data.dart';

class AnimatedListView extends StatelessWidget {

  final Animation<EdgeInsets> listSlidePosition;

  const AnimatedListView({Key? key, required this.listSlidePosition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children:  [
        ListData(
          image: AssetImage('assets/profile.jpg'),
          title: 'Estudar Flutter',
          margin: listSlidePosition.value * 1,
          subtitle: 'Na SH',
        ),
        ListData(
          image: AssetImage('assets/profile.jpg'),
          title: 'Estudar Programação',
          margin: listSlidePosition.value * 0,
          subtitle: 'Na SH',
        ),
      ],
    );
  }
}
