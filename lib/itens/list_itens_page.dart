import 'package:flutter/material.dart';
import 'package:local_db/itens/components/item_detail.dart';
import 'package:local_db/itens/presenter/itens_presenter.dart';
import 'package:local_db/itens/presenter/itens_provider.dart';

import 'model/item.dart';

class ListItensPage extends StatefulWidget {
  const ListItensPage({Key key}) : super(key: key);

  @override
  _ListItensAppState createState() => _ListItensAppState();
}

class _ListItensAppState extends State<ListItensPage> {
  ItensProvider _provider;

  @override
  void initState() {
    _provider = ItensPresenter();
    _provider.obtainItens();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local DB'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetail(provider: _provider),
            ),
          );
        },
      ),
      body: StreamBuilder<List<Item>>(
        stream: _provider.outListItens,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetail(
                        provider: _provider,
                        item: snapshot.data[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  color: Colors.blueGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data[index].name,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            "Description: ${snapshot.data[index].description}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      GestureDetector(
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        onTap: () {
                          _provider.deleteItem(id: snapshot.data[index].id);
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
