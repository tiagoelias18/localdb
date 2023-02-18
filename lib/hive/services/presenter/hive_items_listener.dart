import '../../model/hive_item.dart';

abstract class HiveItemsListener {
  void receiveItems(List<HiveItem> items);
}