import 'package:flutter/cupertino.dart';
import 'package:tasklee/core/constant/app_color.dart';

enum TaskStatus {
  pending,
  completed;

  bool isCompleted() {
    return this == TaskStatus.completed;
  }

  Color getStatusColor() {
    return isCompleted() ? AppColor.taskCompletedColor : AppColor.taskPendingColor;
  }
}
