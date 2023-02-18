import 'package:flutter/material.dart';

import '../model/hive_item.dart';
import '../services/presenter/hive_items_presenter.dart';
import '../services/presenter/hive_items_provider.dart';
import 'widgets/hive_item_detail.dart';

class HiveItemListPage extends StatefulWidget {
  const HiveItemListPage({Key key}) : super(key: key);

  @override
  State<HiveItemListPage> createState() => _HiveItemListPageState();
}

class _HiveItemListPageState extends State<HiveItemListPage> {
  HiveItemsProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = HiveItemsPresenter();
    _provider.obtainItens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Hive DB'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HiveItemDetail(provider: _provider),
            ),
          );
        },
      ),
      body: StreamBuilder<List<HiveItem>>(
        stream: _provider.outListItems,
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
                      builder: (context) => HiveItemDetail(
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
                          _provider.deleteItem(key: snapshot.data[index].key);
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
