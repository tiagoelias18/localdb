import 'package:flutter/material.dart';
import 'package:local_db/itens/model/item.dart';
import 'package:local_db/itens/presenter/itens_provider.dart';

class ItemDetail extends StatefulWidget {
  final ItensProvider provider;
  final Item item;
  const ItemDetail({Key key, this.provider, this.item}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
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
                      id: widget.item?.id,
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
