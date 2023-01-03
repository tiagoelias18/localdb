import 'package:flutter/material.dart';

abstract class ItensInteractorProvider{
  void obtainItens();
  void updateItem({int id, @required String item, String description});
  void deleteItem({@required int id});
}