import 'package:flutter/material.dart';
import 'package:local_db/itens/list_itens_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MaterialApp(
      home: ListItensPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
