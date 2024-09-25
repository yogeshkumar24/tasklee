import 'package:tasklee/core/network_checker.dart';
import 'package:tasklee/task/model/model.dart';
import 'package:tasklee/task/service/task_api_service.dart';
import 'package:tasklee/task/service/task_db_service.dart';

class TaskRepository {
  final TaskApiService taskApiService;
  final TaskDBService taskDBService;

  TaskRepository({
    required this.taskApiService,
    required this.taskDBService,
  });

  Future addTask(Task task) async {
    await taskApiService.addTask(task);
    await taskDBService.addTask(task);
  }

  Future<List<Task>> fetchTasks() async {
    bool hasInternet = await NetworkChecker.hasInternetConnection();
    if (hasInternet) {
      return taskApiService.fetchTasks();
    } else {
      return taskDBService.fetchTasks();
    }
  }

  Future editTask(Task task) async {
    await taskApiService.editTask(task);
    await taskDBService.editTask(task);
  }

  Future<bool> deleteTask(int id) async {
    bool hasDeleted = await taskApiService.deleteTask(id);
    await taskDBService.deleteTask(id);
    return hasDeleted;
  }
}
