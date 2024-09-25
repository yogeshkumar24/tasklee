import 'package:tasklee/task/model/task_priority_enum.dart';
import 'package:tasklee/task/model/task_status_enum.dart';

class Task {
  int? id;
  String title;
  int deadline;
  String? description;
  TaskPriority taskPriority;
  TaskStatus taskStatus;

  Task(
      {required this.title,
      required this.deadline,
      this.id,
      this.taskPriority = TaskPriority.medium,
      this.taskStatus = TaskStatus.pending,
      this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'deadline': deadline,
      'description': description,
      'taskPriority': taskPriority.name,
      'taskStatus': taskStatus.name,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      deadline: map['deadline'],
      description: map['description'],
      taskPriority:
          TaskPriority.values.firstWhere((e) => e.name == map['taskPriority']),
      taskStatus:
          TaskStatus.values.firstWhere((e) => e.name == map['taskStatus']),
    );
  }
}
