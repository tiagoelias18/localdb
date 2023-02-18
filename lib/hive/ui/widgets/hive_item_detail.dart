import 'package:flutter/material.dart';

import '../../model/hive_item.dart';
import '../../services/presenter/hive_items_provider.dart';

class HiveItemDetail extends StatefulWidget {
  final HiveItemsProvider provider;
  final HiveItem item;

  const HiveItemDetail({Key key, this.provider, this.item}) : super(key: key);

  @override
  State<HiveItemDetail> createState() => _HiveItemDetailState();
}

class _HiveItemDetailState extends State<HiveItemDetail> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.item?.name;
    _descriptionController.text = widget.item?.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail page"),
        ),
        body: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField(_nameController, "Item"),
              _buildTextField(_descriptionController, "Description"),
              TextButton(
                onPressed: () async {
                  if (_nameController.text.isNotEmpty) {
                    widget.provider.updateItem(
                      key: widget.item?.key,
                      item: _nameController.text,
                      description: _descriptionController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Salvar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

Widget _buildTextField(TextEditingController controller, String labelText) {
  return Padding(
    padding: const EdgeInsets.all(32.0),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
    ),
  );
}
