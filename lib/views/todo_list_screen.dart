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
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "My Todos",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          _buildSection(
            title: "Completed",
            child: _buildCompleted(),
          ),
          _buildSection(
            child: _buildRemaining(),
            title: "Remaining",
          ),
        ],
      ),
    );
  }

  Widget _buildSection({String? title, Widget? child}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title!,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
            Expanded(
              child: child!,
            ),
          ],
        ),
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

  Widget _buildRemaining() {
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
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      height: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 2,
            spreadRadius: 10,
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
