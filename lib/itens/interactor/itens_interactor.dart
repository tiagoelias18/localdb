import 'package:flutter/material.dart';
import 'package:local_db/itens/interactor/itens_interactor_provider.dart';
import 'package:local_db/itens/interactor/itens_interactor_receiver.dart';
import 'package:local_db/itens/model/item.dart';
import 'package:local_db/itens/presenter/itens_listener.dart';
import 'package:local_db/itens/repository/itens_repository.dart';
import 'package:local_db/itens/repository/itens_sqflite.dart';

class ItensInteractor
    implements ItensInteractorProvider, ItensInteractorReceiver {
  final ItensListener _listener;
  ItensRepository _repository;

  ItensInteractor(this._listener) {
    _repository = ItensSqflite(this);
  }

  @override
  void obtainItens() {
    _repository.readItens();
  }

  @override
  void updateItem({int id, @required String item, String description}) {
    if (id == null) {
      _repository.createItem(Item(name: item, description: description));
      return;
    }
    _repository.updateItem(Item(id: id, name: item, description: description));
  }

  @override
  void deleteItem({@required int id}) {
    _repository.deleteItem(id);
  }
  
  @override
  void receiveItensJson(List<Map<String, dynamic>> itensJson) {
    List<Item> listItens = itensJson.map((json) => Item.fromJson(json)).toList();
    _listener.receiveItens(listItens);
  }
}
