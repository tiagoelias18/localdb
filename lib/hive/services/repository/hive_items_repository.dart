import 'package:local_db/hive/infrastructure/hive_database.dart';

import '../interactor/hive_items_interactor_receiver.dart';
import 'hive_items_executor.dart';

class HiveItemsRepository implements HiveItemsExecutor {
  final HiveItemsInteractorReceiver _receiver;

  HiveItemsRepository({HiveItemsInteractorReceiver receiver})
    : _receiver = receiver;
  
  @override
  void createItem(dynamic key, dynamic value) async {
    final instance = HiveDataBase.instance;
    await instance.hiveItemBox.write(key, value);
  }

  @override
  void readAllItems() async {
    final instance = HiveDataBase.instance;
    final itemsJson = await instance.hiveItemBox.readAll();
    _receiver.receiveItems(itemsJson);
  }

  @override
  void updateItem(dynamic key, dynamic value) async {
    final instance = HiveDataBase.instance;
    await instance.hiveItemBox.update(key, value);
  }

  @override
  void deleteItem(int key) async {
    final instance = HiveDataBase.instance;
    await instance.hiveItemBox.delete(key);
  }
}