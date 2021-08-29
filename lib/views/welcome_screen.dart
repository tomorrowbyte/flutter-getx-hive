import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_todo_screen.dart';
import 'todo_list_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
              "Todoey",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 50),
          ElevatedButton.icon(
            onPressed: () {
              Get.to(() => TodosScreen());
            },
            icon: Icon(Icons.add),
            label: Text("Add Todo"),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Get.to(() => MyTodosScreen());
            },
            icon: Icon(Icons.task),
            label: Text("My Todos"),
          ),
        ],
      ),
    );
  }
}
