import 'package:flutter/foundation.dart';

import '../../model/hive_item.dart';

abstract class HiveItemsProvider {
  void obtainItens();
  void updateItem({dynamic key, @required String item, String description});
  void deleteItem({@required dynamic key});
  Stream<List<HiveItem>> get outListItems;
}
