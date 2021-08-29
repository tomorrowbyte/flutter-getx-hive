import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_todo_screen.dart';
import 'todo_list_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
          SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              "My Todoey hepls you stay organized and perform your tasks much faster.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 50),
          CustomButton(
              onPressed: () {
                Get.to(() => TodosScreen());
              },
              title: 'Add Todo',
              icon: Icons.add),
          SizedBox(height: 20),
          CustomButton(
              onPressed: () {
                Get.to(() => MyTodosScreen());
              },
              title: 'My Todos',
              icon: Icons.task),
        ],
      ),
    );
  }
}
