import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tasklee/core/core.dart';
import 'package:tasklee/task/model/model.dart';
import 'package:tasklee/task/provider/provider.dart';

class AddEditTaskScreen extends StatelessWidget {
  AddEditTaskScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)!.settings.arguments as Task?;
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    if (task != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _titleController.text = task.title;
        _descController.text = task.description ?? '';
        taskProvider
            .setDeadline(DateTime.fromMillisecondsSinceEpoch(task.deadline));
        taskProvider.changePriority(task.taskPriority);
        taskProvider.changeStatus(task.taskStatus);
      });
    }

    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        title: task == null ? AppConstants.addTask : AppConstants.editTask,
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, _) {
          return TranslucentLoader(
            enabled: taskProvider.providerState.isLoading(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppConstants.inputTitle;
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: AppConstants.title),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: AppConstants.description),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: TextEditingController(
                          text: taskProvider.selectedDeadline != null
                              ? DateFormatter.formatDateOnly(taskProvider.selectedDeadline!)
                              : '',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select deadline';
                          }
                        },
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            taskProvider.setDeadline(pickedDate);
                          }
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month),
                          border: OutlineInputBorder(),
                          hintText: 'Select Deadline',
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<TaskPriority>(
                        value: taskProvider.taskPriority,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select task priority';
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: AppConstants.selectPriority,
                          border: OutlineInputBorder(),
                        ),
                        items: TaskPriority.values.map((TaskPriority priority) {
                          return DropdownMenuItem<TaskPriority>(
                            value: priority,
                            child: Text(priority.name.capitalizeFirst),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          taskProvider.changePriority(newValue!);
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<TaskStatus>(
                        value: taskProvider.taskStatus,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select task status';
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: AppConstants.selectStatus,
                          border: OutlineInputBorder(),
                        ),
                        items: TaskStatus.values.map((TaskStatus status) {
                          return DropdownMenuItem<TaskStatus>(
                            value: status,
                            child: Text(status.name.capitalizeFirst),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          taskProvider.changeStatus(newValue!);
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => saveTask(context, task: task),
                        child: Text(task == null
                            ? AppConstants.add
                            : AppConstants.update),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ));
  }

  Future saveTask(BuildContext context, {Task? task}) async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    if ((_formKey.currentState?.validate() ?? false)) {
      if (task == null) {
        Task newTask = Task(
            title: _titleController.text,
            deadline:
                taskProvider.selectedDeadline?.millisecondsSinceEpoch ?? 0,
            description: _descController.text,
            taskPriority: taskProvider.taskPriority!,
            taskStatus: taskProvider.taskStatus!);
        await taskProvider.addTask(newTask);
      } else {
        task.title = _titleController.text;
        task.deadline =
            taskProvider.selectedDeadline?.millisecondsSinceEpoch ?? 0;
        task.description = _descController.text;
        task.taskPriority = taskProvider.taskPriority;
        task.taskStatus = taskProvider.taskStatus;
        await taskProvider.editTask(task);
      }
      if (taskProvider.providerState.isIdeal()) {
        Navigator.pop(context, true);
      }
    }
  }
}
