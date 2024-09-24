import 'package:flutter/material.dart';
import 'package:tasklee/task/view/screen/add_edit_task_screen.dart';
import 'package:tasklee/task/view/screen/task_detail_screen.dart';
import 'package:tasklee/task/view/screen/task_list_screen.dart';

Map<String, WidgetBuilder> routes = {
  AppRoutes.listTask: (context) => const TaskListScreen(),
  AppRoutes.addEditTask: (context) => AddEditTaskScreen(),
  AppRoutes.detailTask: (context) => const TaskDetailScreen(),
};

class AppRoutes {
  static const String listTask = 'list_task';
  static const String addEditTask = 'add_edit_task';
  static const String detailTask = 'detail_task';
}
