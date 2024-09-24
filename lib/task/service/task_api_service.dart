import 'package:tasklee/task/model/model.dart';
import 'package:tasklee/task/service/task_service_abstract.dart';

class TaskApiService implements TaskService {
  @override
  Future addTask(Task task) async {}

  @override
  Future<List<Task>> fetchTask() async {
    throw 'No Implemented';
  }

  @override
  Future editTask(Task task) async {}

  @override
  Future<bool> deleteTask(String id) async {
    return true;
  }
}
