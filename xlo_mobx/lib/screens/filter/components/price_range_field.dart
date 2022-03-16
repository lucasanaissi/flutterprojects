import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/components/price_field.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class PriceRangeField extends StatelessWidget {
  const PriceRangeField({Key? key, required this.filter}) : super(key: key);

  final FilterStore filter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Preço (R\$)'),
          const SizedBox(height: 16),
          Row(
            children: [
              PriceField(
                text: 'Min',
                onChanged: filter.setMinPrice,
                initialValue: filter.minPrice,
              ),
              const SizedBox(width: 10),
              PriceField(
                text: 'Max',
                onChanged: filter.setMaxPrice,
                initialValue: filter.maxPrice,
              ),
            ],
          ),
          Observer(builder: (_) {
            if (filter.priceError != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    filter.priceError!,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          })
        ],
      ),
    );
  }
}
