import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../stores/filter_store.dart';
import '../../stores/home_store.dart';
import 'components/orderby_field.dart';
import 'components/price_range_field.dart';
import 'components/vendor_type_field.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final FilterStore filterStore = GetIt.I<HomeStore>().clonedFilter;

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
            const SizedBox(height: 6),
            PriceRangeField(filter: filterStore),
            const SizedBox(height: 12),
            VendorTypeField(filter: filterStore),
            const SizedBox(height: 12),
            Observer(
              builder: (_) {
                return SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: ElevatedButton(
                    onPressed: filterStore.isFormValid ? () {
                      filterStore.save();
                      Navigator.of(context).pop();
                    } : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      primary: Colors.orange,
                    ),
                    child: const Text(
                      'Filtrar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}
