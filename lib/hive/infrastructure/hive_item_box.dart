import '../model/hive_item.dart';
import 'hive_box.dart';

class HiveItemBox extends HiveBox<HiveItem> {
  HiveItemBox() : super('hive_item_box.db');
}