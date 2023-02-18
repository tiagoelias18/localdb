import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'hive_item_box.dart';

class HiveDataBase {
  static final HiveDataBase instance = HiveDataBase._init();
  static bool isInitialized = false;

  HiveItemBox _hiveItemBox;
  HiveItemBox get hiveItemBox => _hiveItemBox;

  HiveDataBase._init() {
    _initDB();
  }

  Future<void> _initDB() async {
    if (isInitialized) return;

    isInitialized = true;

    final applicationDocsDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(applicationDocsDir.path);

    _hiveItemBox = HiveItemBox();
  }

  Future<void> closeOpenBoxes() async => Hive.close();
}
