import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasklee/core/core.dart';
import 'package:tasklee/task/provider/provider.dart';
import 'package:tasklee/task/view/widget/filter_icon_widget.dart';
import 'package:tasklee/task/view/widget/task_list_widget.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CustomAppBar(
        title: AppText.appName,
        actions: [FilterIconWidget()],
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

  TaskProvider taskProvider(BuildContext context) =>
      Provider.of<TaskProvider>(context, listen: false);

  Future<void> openAddTaskScreen(BuildContext context) async {
    final provider = taskProvider(context);
    provider.reset();
    final result = await Navigator.pushNamed(context, AppRoutes.addEditTask);
    if (result == true) {
      provider.fetchTask();
    }
  }
}
