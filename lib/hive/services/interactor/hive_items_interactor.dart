import 'package:flutter/foundation.dart';
import 'package:local_db/hive/services/repository/hive_items_repository.dart';

import '../../model/hive_item.dart';
import '../presenter/hive_items_listener.dart';
import '../repository/hive_items_executor.dart';
import 'hive_items_interactor_provider.dart';
import 'hive_items_interactor_receiver.dart';

class HiveItemsInteractor
    implements HiveItemsInteractorProvider, HiveItemsInteractorReceiver {
  final HiveItemsListener _listener;
  HiveItemsExecutor _repository;

  HiveItemsInteractor({HiveItemsListener listener})
    : _listener = listener {
    _repository = HiveItemsRepository(receiver: this);
  }

  @override
  void obtainItens() {
    _repository.readAllItems();
  }

  @override
  void updateItem({dynamic key, @required String item, String description}) {
    if (key == null) {
      _repository.createItem(key, HiveItem(name: item, description: description));
      return;
    }
    _repository.updateItem(key, HiveItem(itemKey: key, name: item, description: description));
  }

  @override
  void deleteItem({@required dynamic key}) {
    _repository.deleteItem(key);
  }
  
  @override
  void receiveItems(Map<dynamic, HiveItem> keyItemPairs) {
    final listItens = keyItemPairs.values.toList();
    _listener.receiveItems(listItens);
  }
}
