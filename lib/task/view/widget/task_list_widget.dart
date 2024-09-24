import 'package:flutter/material.dart';
import 'package:tasklee/core/core.dart';
import 'package:tasklee/task/model/model.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    this.task,
  });

  final Task? task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      tileColor: Colors.blueGrey[50],
      trailing: const Icon(Icons.keyboard_arrow_right),
      title: Text(
        task?.title ?? 'Untitled Task',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black87,
        ),
      ),
      subtitle: Text(
        task?.description ?? '',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.detailTask, arguments: task);
      },
    );
  }
}
