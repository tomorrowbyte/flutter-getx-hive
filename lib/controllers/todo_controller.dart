import 'package:get/get.dart';
import 'package:getx_hive/models/todo.dart';
import 'package:hive/hive.dart';

class TodoController extends GetxController {
  var todos = [].obs;

  onInit() {
    Hive.registerAdapter(TodoAdapter());
    getTodos();
    super.onInit();
  }

  addTodo(Todo todo) async {
    todos.add(
      Todo(
        title: "Todo ${todos.length}",
        description: "Testing todo ${todos.length}",
        cdt: DateTime.now().toString(),
      ),
    );
    var box = await Hive.openBox('db');
    box.put('todos', todos.toList());
    print("TOdo Object added $todos");
  }

  getTodos() async {
    Box box;
    try {
      box = await Hive.openBox('db');
    } catch (error) {
      box = Hive.box('db');
    }

    var tds = box.get('db');
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
}
