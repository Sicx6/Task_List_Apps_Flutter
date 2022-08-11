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
