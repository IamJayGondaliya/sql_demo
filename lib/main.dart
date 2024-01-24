import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_demo/controllers/db_controller.dart';
import 'package:sql_demo/helpers/db_helper.dart';
import 'package:sql_demo/views/screens/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDb();

  runApp(
    ChangeNotifierProvider(
      create: (context) => DbController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
