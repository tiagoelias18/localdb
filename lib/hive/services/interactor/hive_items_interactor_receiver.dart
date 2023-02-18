import '../../model/hive_item.dart';

abstract class HiveItemsInteractorReceiver{
  void receiveItems(Map<dynamic, HiveItem> items);
}