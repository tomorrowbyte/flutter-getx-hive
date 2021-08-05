import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive/controllers/todo_controller.dart';
import 'package:getx_hive/models/todo.dart';

class TodosScreen extends StatelessWidget {
  final controller = Get.put(TodoController());

  void addTodo() {
    var todo = Todo(
      title: controller.titleController.text,
      description: controller.descriptionController.text,
      cdt: DateTime.now().toIso8601String(),
    );
    controller.titleController.text = '';
    controller.descriptionController.text = '';
    controller.addTodo(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
              children: [
                Text(
                  "Add Todo",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Enter title"),
                  controller: controller.titleController,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Enter description"),
                  controller: controller.descriptionController,
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: addTodo,
            icon: Icon(Icons.add_task),
            label: Text("Submit"),
          ),
          Divider(),
          Obx(
            () => Text(
              "Todos ${controller.todos.length}",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            child: GetX<TodoController>(
              init: TodoController(),
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.todos.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      background: Container(color: Colors.red),
                      onDismissed: (dir) {
                        // if (dir == DismissDirection.startToEnd) {
                        controller.deleteTodo(index);
                        // }
                      },
                      key: UniqueKey(),
                      child: ListTile(
                        hoverColor: Colors.green,
                        leading: Icon(Icons.task_alt, color: Colors.blue),
                        title: Text(
                          controller.todos[index].title,
                        ),
                        subtitle: Text(
                          controller.todos[index].description,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
