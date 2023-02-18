import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class HiveItem extends HiveObject {
  @HiveField(0)
  final dynamic itemKey;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;

  HiveItem({this.itemKey, this.name, this.description});

  factory HiveItem.fromJson(Map<dynamic, dynamic> json) => HiveItem(
    itemKey: json['key'],
    name: json['name'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() {
    return {
      'key': itemKey,
      'name': name,
      'description': description,
    };
  }
}