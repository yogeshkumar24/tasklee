import 'package:flutter/material.dart';
import 'package:tasklee/core/app_toast.dart';
import 'package:tasklee/core/constant/app_constants.dart';
import 'package:tasklee/core/constant/app_text.dart';
import 'package:tasklee/task/model/model.dart';
import 'package:tasklee/task/provider/provider.dart';
import 'package:tasklee/task/repository/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider(this._taskRepository);

  final TaskRepository _taskRepository;
  List<Task> _taskList = [];
  List<Task> _filteredTaskList = [];
  ProviderState _providerState = ProviderState.ideal;

  TaskPriority _taskPriority = AppConstants.defaultTaskPriority;

  TaskStatus _taskStatus = AppConstants.defaultTaskStatus;

  TaskStatus? _currentTaskStatusFilter;

  DateTime? _selectedDeadline;

  List<Task> get taskList => filteredTaskList;

  // List<Task> get filteredTaskList =>
  //     _filteredTaskList.isNotEmpty && currentTaskStatusFilter != null
  //         ? _filteredTaskList
  //         : _taskList;

  List<Task> get filteredTaskList =>
      _filteredTaskList.isEmpty && currentTaskStatusFilter == null
          ? _taskList
          : _filteredTaskList;

  TaskPriority get taskPriority => _taskPriority;

  TaskStatus get taskStatus => _taskStatus;

  TaskStatus? get currentTaskStatusFilter => _currentTaskStatusFilter;

  DateTime? get selectedDeadline => _selectedDeadline;

  ProviderState get providerState => _providerState;

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
    } else {
      _filteredTaskList = [];
    }
  }

  void setDeadline(DateTime? date) {
    _selectedDeadline = date;
    notifyListeners();
  }

  Future addTask(Task task) async {
    try {
      _providerState = ProviderState.loading;
      notifyListeners();
      await _taskRepository.addTask(task);
      await fetchTask();
      onSuccessEvent(AppText.addTaskSuccessMsg);
    } catch (e) {
      onErrorEvent(e);
    } finally {
      notifyListeners();
    }
  }

  Future fetchTask() async {
    try {
      _providerState = ProviderState.loading;
      notifyListeners();
      _taskList = await _taskRepository.fetchTasks();
      if (_currentTaskStatusFilter != null) {
        filterTaskByStatus(_currentTaskStatusFilter!);
      }
      _providerState = ProviderState.ideal;
    } catch (e) {
      onErrorEvent(e);
    } finally {
      notifyListeners();
    }
  }

  Future editTask(Task task) async {
    try {
      _providerState = ProviderState.loading;
      notifyListeners();
      await _taskRepository.editTask(task);
      await fetchTask();
      onSuccessEvent(AppText.updateTaskMsg);
    } catch (e) {
      onErrorEvent(e);
    } finally {
      notifyListeners();
    }
  }

  Future deleteTask(int id) async {
    try {
      _providerState = ProviderState.loading;
      notifyListeners();
      await _taskRepository.deleteTask(id);
      await fetchTask();
      onSuccessEvent(AppText.deleteTaskMsg);
    } catch (e) {
      onErrorEvent(e);
    } finally {
      notifyListeners();
    }
  }

  void onSuccessEvent(String msg) {
    _providerState = ProviderState.ideal;
    AppToast.showSuccessToast(msg);
  }

  void onErrorEvent(Object e) {
    AppToast.showErrorToast(e.toString());
    _providerState = ProviderState.error;
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
