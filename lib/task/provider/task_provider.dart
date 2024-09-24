import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:tasklee/task/model/model.dart';
import 'package:tasklee/task/provider/provider.dart';
import 'package:tasklee/task/service/task_service_abstract.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider(this._taskService);

  final TaskService _taskService;
  List<Task> _taskList = [];
  List<Task> _filteredTaskList = [];
  ProviderState _providerState = ProviderState.ideal;

  List<Task> get taskList => _taskList;

  List<Task> get filteredTaskList => _filteredTaskList;

  ProviderState get providerState => _providerState;

  Future addTask(Task task) async {
    try {
      _providerState = ProviderState.loading;
      notifyListeners();
      await _taskService.addTask(task);
      _providerState = ProviderState.ideal;
    } catch (e) {
      _providerState = ProviderState.error;
    } finally {
      notifyListeners();
    }
  }

  Future fetchTask() async {
    try {
      _providerState = ProviderState.loading;
      notifyListeners();
      _taskList = await _taskService.fetchTask();
      _providerState = ProviderState.ideal;
    } catch (e) {
      _providerState = ProviderState.error;
    } finally {
      notifyListeners();
    }
  }

  Future editTask(Task task) async {
    try {
      _providerState = ProviderState.loading;
      notifyListeners();
      await _taskService.editTask(task);
      _providerState = ProviderState.ideal;
    } catch (e) {
      _providerState = ProviderState.error;
    } finally {
      notifyListeners();
    }
  }

  Future deleteTask(String id) async {
    try {
      _providerState = ProviderState.loading;
      notifyListeners();
      await _taskService.deleteTask(id);
      _providerState = ProviderState.ideal;
    } catch (e) {
      _providerState = ProviderState.error;
    } finally {
      notifyListeners();
    }
  }

  void filterTaskByStatus(TaskStatus taskStatus) {
    _filteredTaskList =
        _taskList.where((task) => task.taskStatus == taskStatus).toList();
    notifyListeners();
  }
}
