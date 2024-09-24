import 'package:tasklee/task/model/model.dart';

abstract class TaskService {
  Future addTask(Task task);

  Future<List<Task>> fetchTasks();

  Future editTask(Task task);

  Future<bool> deleteTask(int id);
}
