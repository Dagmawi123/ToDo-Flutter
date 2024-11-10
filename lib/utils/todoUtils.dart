// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoUtils extends StatelessWidget {
  final String taskName;
  final bool isCompleted;
  final Function(bool?) onChanged;
  final Function(BuildContext?) onSlide;
  const ToDoUtils(
      {super.key,
      required this.taskName,
      required this.isCompleted,
      required this.onChanged,
      required this.onSlide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
      child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(onPressed: onSlide,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(10),  
              
              )
            ]),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.yellow),
          child: Row(
            children: [
              Checkbox(value: isCompleted, onChanged: onChanged),
              Text(taskName,
                  style: TextStyle(
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none)),
            ],
          ),
        ),
      ),
    );
  }
}
