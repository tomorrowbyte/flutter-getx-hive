import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

void main() async {
  Hive.init('./database');
  var box = await Hive.box('testBox');
  box.put('name', 'David');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Welcome to"),
          Text("My Todo"),
        ],
      ),
    );
  }
}
