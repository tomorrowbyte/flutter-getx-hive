import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive/controllers/todo_controller.dart';
import 'package:getx_hive/models/todo.dart';
import 'package:getx_hive/views/todo_list_screen.dart';
import 'package:getx_hive/widgets/button.dart';
import 'package:getx_hive/widgets/text_field.dart';

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
    Get.off(() => MyTodosScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Add Todo",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            CustomTextFormField(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              borderRadius: BorderRadius.circular(5),
              controller: controller.titleController,
              height: 50.0,
              hintText: "Enter todo title",
              nextFocus: controller.descriptioinFocus,
            ),
            CustomTextFormField(
              padding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
              focus: controller.descriptioinFocus,
              borderRadius: BorderRadius.circular(5),
              controller: controller.descriptionController,
              hintText: "Enter description",
              maxLines: 10,
            ),
            const SizedBox(height: 10),
            PrimaryButton(
              title: "Submit",
              icon: Icons.done,
              onPressed: addTodo,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
