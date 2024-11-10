import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class Db {
  final mybox = Hive.box("myBox");
  List toDoItems = [];
  void InitialData() {
    toDoItems = [
      ["saAdf", false]
    ];
  }

  void loadData() {
    toDoItems = mybox.get("ToDoItems");
  }

  void UpdateData() {
    mybox.put("ToDoItems", toDoItems);
  }
}
