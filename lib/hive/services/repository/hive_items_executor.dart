abstract class HiveItemsExecutor{
  void createItem(dynamic key, dynamic value);
  void readAllItems();
  void updateItem(dynamic key, dynamic value);
  void deleteItem(int key);
}