import 'package:firebase_database/firebase_database.dart';

import '../models/task.dart';

class DatabaseService {
  final databaseReference = FirebaseDatabase.instance;

  DatabaseReference saveTask(Task taskRef) {
    var id = databaseReference.ref('/tasks');
    // var id = databaseReference.refFromURL('https://drugstore-57bec-default-rtdb.firebaseio.com/');
    id.set(taskRef);
    return id;
  }

  void updateTask(Task task, DatabaseReference taskRef) {
    taskRef.update(task.toJson());
  }

  Future<List<Task>> getAllTasks() async {
    DatabaseEvent databaseEvent = await databaseReference.ref('tasks/').once();
    DataSnapshot snapshot = databaseEvent.snapshot;
    List<Task> tasks = [];
    if (snapshot.value != null) {
      snapshot.children.forEach((element) {
        if (element.value != null && element.key != null) {
          // Task task = Task.fromMap(element.value);title:
          var taskRecord = element.value;
          if (taskRecord!= null && taskRecord.id != null && taskRecord.title != null && taskRecord.done != null) {
            Task task = Task(id:taskRecord.id, title: taskRecord.title,  done: taskRecord.done);
            task.setId(databaseReference.ref('posts/${element.key}'));
            tasks.add(task);
          }
        }
      });
    }
    return tasks;
  }
}
