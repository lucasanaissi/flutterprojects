import 'package:flutter/material.dart';

import 'add_size_dialog.dart';

class ProductsSizes extends FormField<List> {
  ProductsSizes({
    BuildContext? context,
    List? initialValue,
    FormFieldSetter<List>? onSaved,
    FormFieldValidator<List>? validator,
  }) : super(
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            builder: (state) {
              return SizedBox(
                height: 34,
                child: GridView(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.5,
                  ),
                  children: state.value!.map((s) {
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                            color: Colors.pinkAccent,
                            width: 3,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          s,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onLongPress: () {
                        state.didChange(state.value!..remove(s));
                      },
                    );
                  }).toList()
                    ..add(
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                              color: Colors.pinkAccent,
                              width: 3,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '+',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onTap: () {
                          showDialog(
                              context: context!,
                              builder: (context) => const AddSizeDialog(),
                          );
                        },
                      ),
                    ),
                ),
              );
            });
}
