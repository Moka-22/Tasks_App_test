import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'homeScreen/home_screen.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('mybox');

  runApp(MyApp(
    title: 'Tasks App',
  ));
}

class MyApp extends StatefulWidget {
  final String title;
  const MyApp({super.key, required this.title});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: widget.title,
      home: HomeScreen(),
    );
  }
}
