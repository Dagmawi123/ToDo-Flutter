import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/DataBase.dart';
import 'package:todo_app/utils/dialog.dart';
import 'package:todo_app/utils/todoUtils.dart';
import 'package:hive/hive.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final mybox = Hive.box("myBox");
  Db toDoDb = Db();
  final controller = TextEditingController();
  // List todoItems = [];


  @override
  void initState() {
    if (mybox.get("ToDoItems") == null) {
      toDoDb.InitialData();
    } else {
      toDoDb.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Center(child: Text("TO DO")),
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: toDoDb.toDoItems.length,
          itemBuilder: (context, index) {
            return ToDoUtils(
              taskName: toDoDb.toDoItems[index][0],
              isCompleted: toDoDb.toDoItems[index][1],
              onChanged: (value) => toggleCheck(value, index),
              onSlide: (context) => RemoveTask(index),
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: OpenDialog, child: const Icon(Icons.add)),
    ));
  }

  void OpenDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: controller,
            SaveTask: AddTask,
          );
        });
  }

  void AddTask() {
    setState(() {
      toDoDb.toDoItems.add([controller.text, false]);
      Navigator.of(context).pop();
      controller.text = "";
    });
    toDoDb.UpdateData();
  }

  RemoveTask(int index) {
    setState(() {
      toDoDb.toDoItems.removeAt(index);
    });
        toDoDb.UpdateData();
  }
    void toggleCheck(bool? value, int index) {
    setState(() {
      toDoDb.toDoItems[index][1] = value;
    });
    toDoDb.UpdateData();
  }
}
