import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

import 'package:note_demo/models/task_model.dart';

class TaskListProviders extends ChangeNotifier {
  List<Task> taskList;

  TaskListProviders({required this.taskList});

  // update() {
  //   final box = GetStorage();
  //   box.write('taskList', taskList.map((e) => e.toMap()).toList());

  //   final list = box.read('tasklist');
  //   print(list);
  //   notifyListeners();
  // }

  addTask(Task task) {
    taskList.add(task);
    notifyListeners();
  }

  deleteTask(int index) {
    taskList.removeAt(index);
    notifyListeners();
  }
}
