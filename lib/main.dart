import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'app.dart';
import 'models/query_data/query_data.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.registerAdapter(QueryDataAdapter());
  Hive.init(directory.path);
  runApp(const MyApp());
}
