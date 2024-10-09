import 'package:flutter/material.dart';
import 'package:sql_sample_june/controller/home_screen_controller.dart';
import 'package:sql_sample_june/view/home_screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HomeScreenController.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
