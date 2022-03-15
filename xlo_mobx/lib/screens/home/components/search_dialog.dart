import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchDialog extends StatefulWidget {
  SearchDialog({Key? key, required this.currentSearch})
      : controller = TextEditingController(),
        super(key: key);

  final String? currentSearch;
  final TextEditingController controller;

  @override
  State<SearchDialog> createState() =>
      _SearchDialogState(currentSearch, controller);
}

class _SearchDialogState extends State<SearchDialog> {
  TextEditingController controller = TextEditingController();

  _SearchDialogState(this.currentSearch, this.controller);

  String? currentSearch;



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print('controller ${controller.text}');
    print('cSearch $currentSearch');
    if (currentSearch != null) {
      controller.text = currentSearch!;
      print('controller ${controller.text}');
    } else {
      controller.text = '';
    }

    return Stack(
      children: [
        Positioned(
          top: 2,
          left: 2,
          right: 2,
          child: Card(
            child: TextField(
              controller: controller,
              cursorWidth: 1.0,
              cursorHeight: 20,
              cursorColor: Colors.deepOrangeAccent,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'Buscar',
                border: InputBorder.none,
                hintStyle: const TextStyle(
                  fontSize: 16,
                ),
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey[700],
                  ),
                  onPressed: Navigator.of(context).pop,
                ),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        onPressed: controller.clear,
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey[700],
                        ),
                      )
                    : null,
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
              autofocus: true,
            ),
          ),
        ),
      ],
    );
  }
}
