import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasklee/core/core.dart';
import 'package:tasklee/task/model/model.dart';
import 'package:tasklee/task/model/task_model.dart';
import 'package:tasklee/task/provider/provider.dart';
import 'package:tasklee/task/view/widget/task_filter_bottom_sheet.dart';
import 'package:tasklee/task/view/widget/task_list_widget.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        title: AppConstants.appName,
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return TaskFilterBottomSheet(
                          (TaskStatus? taskStatus) {
                            taskProvider(context)
                                .setTaskStatusFilter(taskStatus);
                          },
                          selectedTaskStatus:
                              taskProvider(context)
                                  .currentTaskStatusFilter,
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.filter_alt)),
              if (taskProvider(context)
                      .currentTaskStatusFilter !=
                  null)
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
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openAddTaskScreen(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<TaskProvider>(
        builder: (BuildContext context, TaskProvider taskProvider, _) {
          if (taskProvider.providerState.isError()) {
            return const AppErrorWidget();
          }

          return TranslucentLoader(
            enabled: taskProvider.providerState.isLoading(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: taskProvider.taskList.length,
              itemBuilder: (context, index) {
                final task = taskProvider.taskList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TaskListWidget(
                    task: task,
                  ),
                );
              },
            ),
          );
        },
      ),
    ));
  }

  TaskProvider taskProvider(BuildContext context) => Provider.of<TaskProvider>(context, listen: false);

  Future<void> openAddTaskScreen(BuildContext context) async {
    final provider = taskProvider(context);
    provider.reset();
    final result = await Navigator.pushNamed(context, AppRoutes.addEditTask);
    if (result == true) {
      provider.fetchTask();
    }
  }
}
