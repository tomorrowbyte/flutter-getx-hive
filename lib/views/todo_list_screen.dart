import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive/controllers/todo_controller.dart';
import 'package:getx_hive/models/todo.dart';

class MyTodosScreen extends StatelessWidget {
  final controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Todos"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "Todos list",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      child: ListView.builder(
        itemCount: controller.todos.length,
        itemBuilder: (context, index) {
          Todo todo = controller.todos[index];
          return Dismissible(
            onDismissed: (direction) {
              print(direction);
              controller.deleteTodo(index);
            },
            key: UniqueKey(),
            child: ListTile(
              onTap: () {},
              leading: Icon(Icons.gesture_sharp),
              title: Text(todo.title),
              subtitle: Text(todo.description),
            ),
          );
        },
      ),
    );
  }
}
