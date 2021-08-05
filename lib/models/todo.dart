import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(3)
  String cdt;
  @HiveField(4)
  String? udt;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;

  Todo({
    required this.title,
    required this.description,
    required this.cdt,
    this.udt,
  });
  Todo.fromJson(Map json)
      : title = json['title'],
        description = json['description'],
        cdt = json['cdt'],
        udt = json['udt'];

  toJson() {
    return {
      'title': title,
      'description': description,
      'cdt': cdt,
      'udt': udt,
    };
  }
}
