import 'dart:io';

import 'package:admin_virtualstore/blocs/category_bloc.dart';
import 'package:admin_virtualstore/widgets/image_source_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditCategoryDialog extends StatelessWidget {
  final CategoryBloc? _categoryBloc;

  final TextEditingController _controller;

  EditCategoryDialog({Key? key, DocumentSnapshot? category})
      : _categoryBloc = CategoryBloc(category),
        _controller = TextEditingController(
            text: category != null ? category.get('title') : ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          ImageSourceSheet(onImageSelected: (image) {
                            Navigator.of(context).pop();
                            _categoryBloc!.setImage(image);
                          }));
                },
                child: StreamBuilder(
                    stream: _categoryBloc!.outImage,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: snapshot.data! is File
                              ? Image.file(
                                  snapshot.data as File,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  snapshot.data.toString(),
                                  fit: BoxFit.cover,
                                ),
                        );
                      } else {
                        return const Icon(Icons.image);
                      }
                    }),
              ),
              title: StreamBuilder<String>(
                  stream: _categoryBloc!.outTitle,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _controller,
                      onChanged: _categoryBloc!.setTitle,
                      decoration: InputDecoration(
                        errorText: snapshot.hasError
                            ? snapshot.error.toString()
                            : null,
                      ),
                    );
                  }),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              StreamBuilder<bool>(
                  stream: _categoryBloc!.outDelete,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      return TextButton(
                        onPressed: snapshot.data! ? () async {
                          await _categoryBloc!.delete();
                          Navigator.of(context).pop();
                        } : null,
                        child: Text(
                          'Excluir',
                          style: TextStyle(
                            color:
                                snapshot.data! ? Colors.redAccent : Colors.grey,
                          ),
                        ),
                      );
                    }
                  }),
              StreamBuilder<bool>(
                  stream: _categoryBloc!.submitValid,
                  builder: (context, snapshot) {
                    return TextButton(
                      onPressed: snapshot.hasData ? () async {
                        await _categoryBloc!.saveData();
                        Navigator.of(context).pop();
                      } : null,
                      child: Text(
                        'Salvar',
                        style: TextStyle(
                            color:
                                snapshot.hasData ? Colors.blue : Colors.grey),
                      ),
                    );
                  }),
            ]),
          ],
        ),
      ),
    );
  }
}
