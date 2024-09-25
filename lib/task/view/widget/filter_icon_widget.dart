import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasklee/task/model/model.dart';
import 'package:tasklee/task/provider/provider.dart';
import 'package:tasklee/task/view/widget/task_filter_bottom_sheet.dart';

class FilterIconWidget extends StatelessWidget {
  const FilterIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        return Stack(
          children: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return TaskFilterBottomSheet(
                        (TaskStatus? taskStatus) {
                          taskProvider.setTaskStatusFilter(taskStatus);
                        },
                        selectedTaskStatus:
                            taskProvider.currentTaskStatusFilter,
                      );
                    },
                  );
                },
                icon: const Icon(Icons.filter_alt)),
            if (taskProvider.currentTaskStatusFilter != null)
              const Positioned(
                right: 12,
                child: Text(
                  '.',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
              )
          ],
        );
      },
    );
  }
}
