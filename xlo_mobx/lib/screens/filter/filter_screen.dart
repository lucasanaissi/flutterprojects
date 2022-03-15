import 'package:flutter/material.dart';

import '../../stores/filter_store.dart';
import 'components/orderby_field.dart';
import 'components/price_range_field.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  final FilterStore filterStore = FilterStore();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Filtrar buscas'),
      ),
      body: ListView(
        children: [
          OrderByField(filter: filterStore),
          const SizedBox(height: 10),
          PriceRangeField(filter: filterStore),
        ],
      ),
    );
  }
}
