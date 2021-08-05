import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive/controllers/todo_controller.dart';
import 'package:getx_hive/models/todo.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.deleteBoxFromDisk('testBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
    var controller = Get.put(TodoController());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          ElevatedButton.icon(
            onPressed: () {
              controller.addTodo(
                Todo(
                  title: 'Test',
                  description: "Description",
                  cdt: DateTime.now().toIso8601String(),
                ),
              );
            },
            icon: Icon(Icons.add),
            label: Text("Add Todo"),
          ),
          ElevatedButton.icon(
            onPressed: () {
              controller.clearTodos();
            },
            icon: Icon(Icons.delete_forever),
            label: Text("Clear"),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              "Welcome to",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              "My Todo",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: controller.todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      controller.todos[index].title,
                    ),
                    subtitle: Text(controller.todos[index].description),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
