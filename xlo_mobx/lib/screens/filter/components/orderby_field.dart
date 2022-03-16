import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';

import '../../../stores/filter_store.dart';

class OrderByField extends StatelessWidget {
  const OrderByField({Key? key, this.filter}) : super(key: key);

  final FilterStore? filter;

  @override
  Widget build(BuildContext context) {
    Widget buildOption(String title, OrderBy option) {
      return GestureDetector(
        onTap: () {
          filter!.setOrderBy(option);
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color:
                  filter!.orderBy == option ? Colors.deepPurple : Colors.grey,
            ),
            color: filter!.orderBy == option
                ? Colors.deepPurple
                : Colors.transparent,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: filter!.orderBy == option ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Ordenação por'),
          const SizedBox(height: 10),
          Observer(builder: (_) {
            return Row(
              children: [
                buildOption('Data', OrderBy.DATE),
                const SizedBox(width: 16),
                buildOption('Preço', OrderBy.PRICE),
                const SizedBox(width: 16),
                buildOption('Relevância', OrderBy.RELEVENCE),
              ],
            );
          })
        ],
      ),
    );
  }
}
