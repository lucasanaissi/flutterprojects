import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/page_section.dart';
import 'custom_drawer_header.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: ListView(
          children: [
            CustomDrawerHeader(),
            PageSection(),
          ],
        ),
      ),
    );
  }
}
