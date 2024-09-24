import 'package:flutter/material.dart';
import 'package:tasklee/core/app_constants.dart';
import 'package:tasklee/task/model/model.dart';
import 'package:tasklee/task/provider/provider.dart';
import 'package:tasklee/task/service/task_service_abstract.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider(this._taskService);

  final TaskService _taskService;
  List<Task> _taskList = [];
  List<Task> _filteredTaskList = [];
  ProviderState _providerState = ProviderState.ideal;

  TaskPriority _taskPriority = AppConstants.defaultTaskPriority;

  TaskStatus _taskStatus = AppConstants.defaultTaskStatus;

  TaskStatus? _currentTaskStatusFilter;

  DateTime? _selectedDeadline;

  List<Task> get taskList => _taskList;

  TaskPriority get taskPriority => _taskPriority;

  TaskStatus get taskStatus => _taskStatus;

  TaskStatus? get currentTaskStatusFilter => _currentTaskStatusFilter;

  DateTime? get selectedDeadline => _selectedDeadline;

  void changePriority(TaskPriority taskPriority) {
    _taskPriority = taskPriority;
  }

  void changeStatus(TaskStatus taskStatus) {
    _taskStatus = taskStatus;
  }

  void setTaskStatusFilter(TaskStatus? taskStatus) {
    _currentTaskStatusFilter = taskStatus;
    notifyListeners();
    if (taskStatus != null) {
      filterTaskByStatus(taskStatus);
    }
  }

  void setDeadline(DateTime? date) {
    _selectedDeadline = date;
    notifyListeners();
  }

  List<Task> get filteredTaskList => _filteredTaskList;

  ProviderState get providerState => _providerState;

  Future addTask(Task task) async {
    try {
      _providerState = ProviderState.loading;
      notifyListeners();
      await _taskService.addTask(task);
      //_taskList.add(task);
      //TODO show success Toast here
      _providerState = ProviderState.ideal;
    } catch (e) {
      _providerState = ProviderState.error;
      //TODO show error Toast here
    } finally {
      notifyListeners();
    }
  }

  Future fetchTask() async {
    try {
      _providerState = ProviderState.loading;
      notifyListeners();
      _taskList = await _taskService.fetchTasks();
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
      await fetchTask();
      _providerState = ProviderState.ideal;
    } catch (e) {
      _providerState = ProviderState.error;
    } finally {
      notifyListeners();
    }
  }

  Future deleteTask(int id) async {
    try {
      _providerState = ProviderState.loading;
      notifyListeners();
      await _taskService.deleteTask(id);
      // _taskList.removeWhere((task) => task.id == id);
      await fetchTask();
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

  void reset() {
    _selectedDeadline = null;
    _taskPriority = AppConstants.defaultTaskPriority;
    _taskStatus = AppConstants.defaultTaskStatus;
  }
}
