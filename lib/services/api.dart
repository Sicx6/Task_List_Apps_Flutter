import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_demo/models/task_model.dart';

Future<List<Task>> getTaskList() async {
  final snapshot = await FirebaseFirestore.instance.collection('task').get();

  return snapshot.docs.map((e) => Task.fromMap(e.data())).toList();
}

Stream<List<Task>> getTaskListStream() {
  final snapshots = FirebaseFirestore.instance
      .collection('task')
      .orderBy('createdDate', descending: true)
      .snapshots();
  return snapshots.map((snapshot) =>
      snapshot.docs.map((e) => Task.fromMap(e.data(), id: e.id)).toList());
}

Future<bool> addTask(Task task) async {
  try {
    await FirebaseFirestore.instance.collection('task').add(task.toMap());
    return true;
  } catch (e) {
    print(e);
    throw (e);
  }
}

Future<bool> deleteTask(String taskId) async {
  try {
    await FirebaseFirestore.instance.doc('task/$taskId').delete();
    return true;
  } catch (e) {
    print(e);
    throw (e);
  }
}








// import 'package:dio/dio.dart';
// import 'package:note_demo/models/toDo_model.dart';

// Future<List<ToDo>> getToDo() async { 
//   try {
//     Response response =
//         await Dio().get('https://jsonplaceholder.typicode.com/todos');
//     List<dynamic> data = response.data;
//     print(data);

//     List<ToDo> toDoList = data.map((e) => ToDo.fromMap(e)).toList();

//     return toDoList;
//     // print(response.data[0]);
//   } catch (e) {
//     print(e);
//     return [];
//   }
// }