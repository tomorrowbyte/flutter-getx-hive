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
            Icons.data_exploration,
            size: 60,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  todo.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Created: ",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(timeago.format(todo.cdt))
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Description: ",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(todo.description),
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
