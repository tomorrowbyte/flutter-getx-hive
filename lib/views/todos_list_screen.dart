import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive/controllers/todo_controller.dart';
import 'package:getx_hive/models/todo.dart';

class TodosScreen extends StatelessWidget {
  final controller = Get.put(TodoController());

  void addTodo() {
    if (controller.titleController.text.isEmpty ||
        controller.descriptionController.text.isEmpty) return;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Todo"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 40,
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Add your task to list",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Enter title",
                      border: InputBorder.none,
                    ),
                    controller: controller.titleController,
                    onEditingComplete: () {
                      controller.descriptioinFocus.requestFocus();
                    },
                  ),
                ),
                Container(
                  height: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    maxLines: 10,
                    focusNode: controller.descriptioinFocus,
                    decoration: InputDecoration(
                      hintText: "Enter description",
                      border: InputBorder.none,
                    ),
                    controller: controller.descriptionController,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: TextButton.icon(
                      onPressed: addTodo,
                      icon: Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
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
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
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
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              controller.toggleTodo(index);
                            },
                            leading: Icon(
                              Icons.done_all,
                              color: controller.todos[index].isDone
                                  ? Colors.green
                                  : Colors.grey,
                              size: 42,
                            ),
                            title: Text(
                              controller.todos[index].title,
                            ),
                            subtitle: Text(
                              controller.todos[index].description,
                            ),
                            trailing: Text(
                              controller.todos[index].cdt.substring(0, 10),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
