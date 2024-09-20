import 'package:flutter/cupertino.dart';
import 'package:todo_list/Services/database_service.dart';
import '../Services/task_client.dart';
import 'task.dart';

class TasksData extends ChangeNotifier {
  List<Task> tasks = [];
  DatabaseService databaseService;

  TasksData(this.databaseService);

  void addTask(String taskTitle) async {
    Task task = await TaskClient.addTask(taskTitle);
    // Task task = databaseService.saveTask(taskTitle);
    tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggle();
    // TaskClient.updateTask(task.id);
    databaseService.updateTask(task, task.idRef);
    notifyListeners();
  }

  void deleteTask(Task task) {
    tasks.remove(task);
    TaskClient.deleteTask(task.id);
    notifyListeners();
  }
}
