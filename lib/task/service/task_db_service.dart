import 'package:tasklee/task/model/model.dart';
import 'package:tasklee/task/service/task_service_abstract.dart';

class TaskDBService implements TaskService {

  @override
  Future addTask(Task task) async {
    //TODO add task in DB
  }

  @override
  Future<List<Task>> fetchTasks() async {
    //TODO fetchTasks
    return [];
  }

  @override
  Future editTask(Task task) async {}

  @override
  Future<bool> deleteTask(int id) async {
    return true;
  }
}
