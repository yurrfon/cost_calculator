import 'package:cost_calculator/pages/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Hive.initFlutter();
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COST CALCULATOR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MenuPage(title: "COST CALCULATOR"),
    );
  }
}
