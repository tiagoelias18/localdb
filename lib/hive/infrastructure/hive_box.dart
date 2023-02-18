import 'dart:async';

import 'package:hive/hive.dart';

abstract class HiveBox<T> {
  final String _boxName;

  String get boxName => _boxName;
  FutureOr<Box<T>> get hiveBox async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<T>(_boxName);
    }
    return await Hive.openBox<T>(boxName);
  }

  HiveBox(String boxName)
    : _boxName = boxName,
      assert(boxName != null);

  Future<void> write(dynamic key, dynamic value) async {
    final result = (await hiveBox).put(key, value);
    Hive.close();
    return result;
  }

  dynamic read(dynamic key, {dynamic defaultValue}) async {
    final result = (await hiveBox).get(key, defaultValue: defaultValue);
    Hive.close();
    return result;
  }

  Future<Map<dynamic, T>> readAll() async => (await hiveBox).toMap();

  Future<void> update(dynamic key, dynamic value) async {
    final result = (await hiveBox).put(key, value);
    Hive.close();
    return result;
  }

  Future<void> delete(int key) async {
    final result = (await hiveBox).delete(key);
    Hive.close();
    return result;
  }
}