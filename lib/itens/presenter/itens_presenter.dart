import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_db/itens/interactor/itens_interactor.dart';
import 'package:local_db/itens/interactor/itens_interactor_provider.dart';
import 'package:local_db/itens/model/item.dart';
import 'package:local_db/itens/presenter/itens_listener.dart';
import 'package:local_db/itens/presenter/itens_provider.dart';

class ItensPresenter extends ChangeNotifier
    implements ItensProvider, ItensListener {
  ItensInteractorProvider _interactor;
  final _listItensController = StreamController<List<Item>>();

  ItensPresenter() {
    _interactor = ItensInteractor(this);
  }

  @override
  Stream<List<Item>> get outListItens => _listItensController.stream;

  @override
  void obtainItens() {
    _interactor.obtainItens();
  }

  @override
  void updateItem({int id, @required String item, String description}) {
    _interactor.updateItem(id: id, item: item, description: description);
    obtainItens();
  }

  @override
  void deleteItem({@required int id}) {
    _interactor.deleteItem(id: id);
    obtainItens();
  }

  @override
  void receiveItens(List<Item> itens) {
    _listItensController.sink.add(itens);
  }

  @override
  void dispose() {
    _listItensController.close();
    super.dispose();
  }
}
