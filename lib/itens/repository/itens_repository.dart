import 'package:local_db/itens/model/item.dart';

abstract class ItensRepository{
  void createItem(Item item);
  void readItens();
  void updateItem(Item item);
  void deleteItem(int id);
}