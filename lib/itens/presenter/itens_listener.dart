import 'package:local_db/itens/model/item.dart';

abstract class ItensListener {
  void receiveItens(List<Item> itens);
}