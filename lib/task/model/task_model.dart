import 'package:tasklee/task/model/task_priority_enum.dart';
import 'package:tasklee/task/model/task_status_enum.dart';

class Task {
  int? id;
  String title;
  int deadline;
  String? description;
  TaskPriority taskPriority;
  TaskStatus taskStatus;

  Task({
    required this.title,
    required this.deadline,
    this.id,
    this.taskPriority = TaskPriority.medium,
    this.taskStatus = TaskStatus.pending,
    this.description
  });
}
