import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive/controllers/todo_controller.dart';
import 'package:getx_hive/models/todo.dart';
import 'package:timeago/timeago.dart' as timeago;

class TodosScreen extends StatelessWidget {
  final controller = Get.put(TodoController());

  void addTodo() {
    if (controller.titleController.text.isEmpty ||
        controller.descriptionController.text.isEmpty) return;
    var todo = Todo(
      id: UniqueKey().toString(),
      title: controller.titleController.text,
      description: controller.descriptionController.text,
      cdt: DateTime.now(),
    );
    controller.titleController.text = '';
    controller.descriptionController.text = '';
    controller.addTodo(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Add Todo"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        height: Get.height,
        child: Expanded(
          child: SingleChildScrollView(
            child: Container(
              height: Get.height,
              child: Column(
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
                            "Add your task",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          borderRadius: BorderRadius.circular(25),
                          controller: controller.titleController,
                          height: 50.0,
                          hintText: "Enter todo title",
                          nextFocus: controller.descriptioinFocus,
                        ),
                        CustomTextFormField(
                          padding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                          focus: controller.descriptioinFocus,
                          borderRadius: BorderRadius.circular(10),
                          controller: controller.descriptionController,
                          height: 100.0,
                          hintText: "Enter description",
                          maxLines: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    title: "Submit",
                    icon: Icons.done,
                    onPressed: addTodo,
                  ),
                  const SizedBox(height: 10),
                  // Divider(),
                  // Obx(
                  //   () => Text(
                  //     "Todos (${controller.todos.length})",
                  //     style: TextStyle(
                  //       fontSize: 22,
                  //       fontWeight: FontWeight.w900,
                  //     ),
                  //   ),
                  // ),
                  // _buildTodosList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildTodosList() {
    return Expanded(
      child: GetX<TodoController>(
        init: TodoController(),
        builder: (controller) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemCount: controller.todos.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.delete, color: Colors.white),
                        Icon(Icons.delete, color: Colors.white),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red,
                    ),
                  ),
                  onDismissed: (dir) {
                    controller.deleteTodo(controller.todos[index]);
                  },
                  key: UniqueKey(),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        controller.toggleTodo(controller.todos[index]);
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
                      trailing: Text(
                        timeago.format(
                          controller.todos[index].cdt,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.icon,
    this.height = 40.0,
    this.color,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String title;
  final IconData icon;
  final double height;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: color ?? Theme.of(context).primaryColor,
              ),
              child: TextButton.icon(
                onPressed: onPressed,
                icon: Icon(
                  icon,
                  color: Colors.white,
                ),
                label: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.height,
    required this.hintText,
    this.borderRadius,
    this.nextFocus,
    this.focus,
    this.maxLines,
    this.padding,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final double height;
  final BorderRadius? borderRadius;
  final FocusNode? nextFocus;
  final FocusNode? focus;
  final int? maxLines;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ),
      child: TextFormField(
        autofocus: true,
        focusNode: focus,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
        controller: controller,
        onEditingComplete: () {
          nextFocus?.requestFocus();
        },
      ),
    );
  }
}
