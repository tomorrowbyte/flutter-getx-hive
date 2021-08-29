import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive/models/todo.dart';
import 'package:hive/hive.dart';

class TodoController extends GetxController {
  var todos = [].obs;
  var done = [].obs;
  var remaining = [].obs;

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
    for (Todo todo in todos) {
      if (todo.isDone) {
        done.add(todo);
      } else {
        remaining.add(todo);
      }
    }
  }

  clearTodos() {
    try {
      Hive.deleteBoxFromDisk('db');
    } catch (error) {
      print(error);
    }
    todos.value = [];
  }

  deleteTodo(Todo todo) async {
    todos.remove(todo);
    var box = await Hive.openBox('db');
    box.put('todos', todos.toList());
  }

  toggleTodo(Todo todo) async {
    var index = todos.indexOf(todo);
    var editTodo = todos[index];
    editTodo.isDone = !editTodo.isDone;
    if (editTodo.isDone) {
      done.add(editTodo);
      remaining.remove(editTodo);
    } else {
      done.remove(editTodo);
      remaining.add(editTodo);
    }
    todos[index] = editTodo;
    var box = await Hive.openBox('db');
    box.put('todos', todos.toList());
  }
}
