import 'package:tasklee/task/model/model.dart';
import 'package:tasklee/task/service/task_service_abstract.dart';

class TaskApiService implements TaskService {
  //Mock data
  final List<Task> _taskList = [];

  @override
  Future addTask(Task task) async {
    await Future.delayed(const Duration(seconds: 2));
    int id = DateTime.now().millisecondsSinceEpoch;
    task.id = id;
    _taskList.add(task);
  }

  @override
  Future<List<Task>> fetchTasks() async {
    await Future.delayed(const Duration(seconds: 2));
    return [..._taskList];
  }

  @override
  Future editTask(Task task) async {
    await Future.delayed(const Duration(seconds: 2));
    int index = _taskList.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _taskList[index] = task;
    }
  }

  @override
  Future<bool> deleteTask(int id) async {
    await Future.delayed(const Duration(seconds: 2));
    _taskList.removeWhere((task) => task.id == id);
    return true;
  }
}
