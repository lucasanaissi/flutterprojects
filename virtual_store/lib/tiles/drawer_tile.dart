import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

    DrawerTile(this.icon,  this.text,  this.controller, this.page, {Key? key})
  :
    super (key: key);

  final IconData icon;
  final String text;
  final PageController controller;
  final int page;



  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: controller.page?.round() == page ?
                Theme.of(context).colorScheme.primary : Colors.white,
              ),
              const SizedBox(width: 32),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.page?.round() == page ?
                  Theme.of(context).colorScheme.primary : Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}
