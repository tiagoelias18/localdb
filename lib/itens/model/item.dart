class Item {
  final int id;
  final String name;
  final String description;

  Item({this.id, this.name, this.description});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      id: json['id'], name: json['name'], description: json['description']);

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}