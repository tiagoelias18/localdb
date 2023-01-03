import 'package:flutter/material.dart';
import 'package:local_db/itens/model/item.dart';

abstract class ItensProvider {
  void obtainItens();
  void updateItem({int id, @required String item, String description});
  void deleteItem({@required int id});
  Stream<List<Item>> get outListItens;
}
