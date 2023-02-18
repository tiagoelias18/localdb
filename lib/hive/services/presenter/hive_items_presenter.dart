import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../model/hive_item.dart';
import '../interactor/hive_items_interactor.dart';
import '../interactor/hive_items_interactor_provider.dart';
import 'hive_items_listener.dart';
import 'hive_items_provider.dart';

class HiveItemsPresenter extends ChangeNotifier
    implements HiveItemsProvider, HiveItemsListener {
  HiveItemsInteractorProvider _interactor;
  final _listItensController = StreamController<List<HiveItem>>();

  HiveItemsPresenter() {
    _interactor = HiveItemsInteractor(listener: this);
  }

  @override
  Stream<List<HiveItem>> get outListItems => _listItensController.stream;

  @override
  void obtainItens() {
    _interactor.obtainItens();
  }

  @override
  void updateItem({dynamic key, @required String item, String description}) {
    _interactor.updateItem(key: key, item: item, description: description);
    obtainItens();
  }

  @override
  void deleteItem({@required dynamic key}) {
    _interactor.deleteItem(key: key);
    obtainItens();
  }

  @override
  void receiveItems(List<HiveItem> items) {
    _listItensController.sink.add(items);
  }

  @override
  void dispose() {
    _listItensController.close();
    super.dispose();
  }
}
