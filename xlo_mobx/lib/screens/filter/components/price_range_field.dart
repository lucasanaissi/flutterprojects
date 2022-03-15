import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:xlo_mobx/screens/filter/components/price_field.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class PriceRangeField extends StatelessWidget {
  const PriceRangeField({Key? key, this.filter}) : super(key: key);

  final FilterStore? filter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Preço (R\$)'),
          const SizedBox(height: 10),
          Row(
            children: [
              PriceField(text: 'Min',),
              SizedBox(width: 10),
              PriceField(text: 'Max'),
            ],
          )
        ],
      ),
    );
  }
}
