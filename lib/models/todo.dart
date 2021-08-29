import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(3)
  DateTime cdt;
  @HiveField(4)
  DateTime? udt;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  bool isDone;
  @HiveField(5)
  String id;

  Todo({
    required this.title,
    required this.description,
    required this.cdt,
    this.isDone = false,
    required this.id,
    this.udt,
  });
  Todo.fromJson(Map json)
      : title = json['title'],
        description = json['description'],
        cdt = json['cdt'],
        isDone = json['isDone'],
        id = json['id'],
        udt = json['udt'];

  toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'cdt': cdt,
      'udt': udt,
      'isDone': isDone,
    };
  }
}
