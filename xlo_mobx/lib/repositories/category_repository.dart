import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

import '../models/category.dart';

class CategoryRepository {
 Future<List<Category>> getList() async {
   try {
     final queryBuilder = QueryBuilder(ParseObject(keyCategoryTable))
       ..orderByAscending(keyCategoryDescription);

     final response = await queryBuilder.query();

     if (response.success) {
       return response.results!.map((e) => Category.fromParse(e)).toList();
     } else {
       throw ParseErrors.getDescription(response.error!.code).toString();
     }
   } catch (e) {
     return Future.error(e);
   }
  }
}
