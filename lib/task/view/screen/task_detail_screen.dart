import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasklee/core/core.dart';
import 'package:tasklee/task/model/model.dart';
import 'package:tasklee/task/provider/provider.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)!.settings.arguments as Task;

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppText.taskDetailTitle,
        ),
        backgroundColor: Colors.grey[200],
        body: Consumer<TaskProvider>(
          builder: (context, taskProvider, _) {
            if (taskProvider.providerState.isError()) {
              return const AppErrorWidget();
            }
            return TranslucentLoader(
              enabled: taskProvider.providerState.isLoading(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textColor,
                          ),
                        ),
                        if (task.description != null &&
                            task.description!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              task.description!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColor.textColor,
                              ),
                            ),
                          ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Icon(Icons.priority_high,
                                color: AppColor.priorityColor, size: 24),
                            const SizedBox(width: 12),
                            Text(
                              '${AppText.priority}: ${task.taskPriority.name.capitalizeFirst}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.textColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            task.taskStatus.isCompleted()
                                ? Icon(Icons.check_circle,
                                    color: task.taskStatus.getStatusColor(),
                                    size: 24)
                                : Icon(Icons.access_time_filled,
                                    color: task.taskStatus.getStatusColor(),
                                    size: 24),
                            const SizedBox(width: 12),
                            Text(
                              '${AppText.status}: ${task.taskStatus.name.capitalizeFirst}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.textColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 24),
                            const SizedBox(width: 12),
                            Text(
                              '${AppText.deadline}: ${DateFormatter.formatDateOnlyFromMilliseconds(task.deadline)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.textColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDeleteConfirmationDialog(context,
                                      onConfirm: () {
                                    deleteTask(context, taskProvider, task);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColor.alertColor,
                                )),
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.addEditTask,
                                      arguments: task);
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () =>
                                    updateTaskStatus(task, taskProvider),
                                icon: Icon(
                                  Icons.done,
                                  color: task.taskStatus.getStatusColor(),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void updateTaskStatus(Task task, TaskProvider taskProvider) {
    if (task.taskStatus.isCompleted()) {
      task.taskStatus = TaskStatus.pending;
    } else {
      task.taskStatus = TaskStatus.completed;
    }
    taskProvider.editTask(task);
  }

  void deleteTask(
      BuildContext context, TaskProvider taskProvider, Task task) async {
    await taskProvider.deleteTask(task.id!);
    if (taskProvider.providerState.isIdeal()) {
      Navigator.pop(context);
    }
  }
}
