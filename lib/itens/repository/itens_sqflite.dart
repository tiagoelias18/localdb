import 'package:local_db/infrastructure/sqflite_database.dart';
import 'package:local_db/itens/interactor/itens_interactor_receiver.dart';
import 'package:local_db/itens/model/item.dart';
import 'package:local_db/itens/repository/itens_repository.dart';

class ItensSqflite implements ItensRepository {
  ItensInteractorReceiver _receiver;

  ItensSqflite(this._receiver);
  
  @override
  void createItem(Item item) async {
   await SqfliteDataBase.instance.create(item);
  }

  @override
  void readItens() async {
    List<Map<String,dynamic>> itensJson = await SqfliteDataBase.instance.read();
    _receiver.receiveItensJson(itensJson);
  }

  @override
  void updateItem(Item item) async {
    await SqfliteDataBase.instance.update(item);
  }

  @override
  void deleteItem(int id) async {
    await SqfliteDataBase.instance.delete(id);
  }
}