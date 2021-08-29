import 'package:flutter/material.dart';
import 'package:getx_hive/models/todo.dart';
import 'package:timeago/timeago.dart' as timeago;

class ViewTodoScreen extends StatelessWidget {
  const ViewTodoScreen({
    Key? key,
    required this.todo,
  }) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          todo.title,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          Icon(
            Icons.task_outlined,
            size: 60,
          ),
          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Title: "),
                    Text(todo.title),
                  ],
                ),
                Row(
                  children: [
                    Text("Description: "),
                    Text(todo.description),
                  ],
                ),
                Row(
                  children: [
                    Text("Created: "),
                    Text(
                      timeago.format(todo.cdt),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
