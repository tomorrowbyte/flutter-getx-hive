import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive/controllers/todo_controller.dart';
import 'package:getx_hive/models/todo.dart';
import 'package:getx_hive/views/add_todo_screen.dart';
import 'package:getx_hive/views/view_todo_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyTodosScreen extends StatelessWidget {
  final controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.off(() => TodosScreen());
        },
        label: Row(
          children: [
            Icon(Icons.add),
            SizedBox(width: 10),
            Text("Add todo"),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 45),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios_new),
                ),
                Text(
                  "My Todos",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                // Icon(Icons),
                SizedBox()
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Completed",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: _buildCompleted(),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Remaining",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: _buildInCompleted(),
          ),
        ],
      ),
    );
  }

  Widget _buildCompleted() {
    return Obx(
      () => Container(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller.done.length,
          itemBuilder: (context, index) {
            Todo todo = controller.done[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => ViewTodoScreen(todo: todo));
              },
              onLongPress: () {
                controller.toggleTodo(todo);
              },
              child: TodoCard(
                isDone: todo.isDone,
                title: todo.title,
                date: todo.cdt,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInCompleted() {
    return Obx(
      () => Container(
        child: ListView.builder(
          itemCount: controller.remaining.length,
          itemBuilder: (context, index) {
            Todo todo = controller.remaining[index];
            return GestureDetector(
              onLongPress: () {
                controller.toggleTodo(todo);
              },
              child: TodoCard(
                isDone: todo.isDone,
                title: todo.title,
                date: todo.cdt,
              ),
            );
          },
        ),
      ),
    );
  }
}

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
    required this.title,
    required this.date,
    required this.isDone,
  }) : super(key: key);
  final String title;
  final DateTime date;
  final bool isDone;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      height: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 20,
            spreadRadius: 1,
          )
        ],
        color: isDone ? Colors.green[50] : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.task_alt,
                  color: isDone ? Colors.green : Colors.grey,
                ),
                SizedBox(width: 5),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Text(timeago.format(date)),
        ],
      ),
    );
  }
}
