import 'package:flutter/material.dart';
import 'package:todo_app/utils/customButton.dart';

class DialogBox extends StatelessWidget {
  // const DialogBox({super.key});
  final TextEditingController controller;
  final VoidCallback SaveTask;
  const DialogBox(
      {super.key, required this.SaveTask, required this.controller});
  // DialogBox({required this.controller});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add New Task", style: TextStyle(fontSize: 20)),
      content: Container(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: "Enter Task here", border: OutlineInputBorder()),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(
                    text: "Save",
                    onPressed: SaveTask,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MyButton(
                    text: "Cancel",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
