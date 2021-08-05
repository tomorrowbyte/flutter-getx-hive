import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive/models/todo.dart';
import 'package:hive/hive.dart';

class TodoController extends GetxController {
  var todos = [].obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode titleFocus = FocusNode();
  FocusNode descriptioinFocus = FocusNode();

  onInit() {
    try {
      Hive.registerAdapter(TodoAdapter());
    } catch (e) {
      print(e);
    }
    getTodos();
    super.onInit();
  }

  addTodo(Todo todo) async {
    todos.add(todo);
    var box = await Hive.openBox('db');
    box.put('todos', todos.toList());
    print("To Do Object added $todos");
  }

  Future getTodos() async {
    Box box;
    print("Getting todos");
    try {
      box = Hive.box('db');
    } catch (error) {
      box = await Hive.openBox('db');
      print(error);
    }

    var tds = box.get('todos');
    print("TODOS $tds");
    if (tds != null) todos.value = tds;
  }

  clearTodos() {
    try {
      Hive.deleteBoxFromDisk('db');
    } catch (error) {
      print(error);
    }
    todos.value = [];
  }

  deleteTodo(index) async {
    todos.removeAt(index);
    var box = await Hive.openBox('db');
    box.put('todos', todos.toList());
  }

  toggleTodo(index) async {
    var todo = todos[index];
    todo.isDone = !todo.isDone;
    todos[index] = todo;
    var box = await Hive.openBox('db');
    box.put('todos', todos.toList());
  }
}
