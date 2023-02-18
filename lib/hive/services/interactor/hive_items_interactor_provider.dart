import 'package:flutter/foundation.dart';

abstract class HiveItemsInteractorProvider{
  void obtainItens();
  void updateItem({dynamic key, @required String item, String description});
  void deleteItem({@required dynamic key});
}