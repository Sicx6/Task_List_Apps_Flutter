import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_demo/models/task_model.dart';

import 'package:note_demo/providers/task_list_providers.dart';
import 'package:note_demo/providers/users_provider.dart';
import 'package:note_demo/screens/landing_page_screen.dart';
import 'package:note_demo/screens/test_screen.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final box = GetStorage();

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final taskList = box.read('taskList');

    final List<Task> list = taskList != null
        ? List.from((taskList as List<dynamic>).map((e) => Task.fromMap(e)))
        : [];

    final taskListProviders = TaskListProviders(taskList: list);
    final appUsers = AppUsers();

    print(list);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskListProviders>.value(
            value: taskListProviders),
        ChangeNotifierProvider<AppUsers>.value(value: appUsers),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.purple,
            ),
            home: const LandingPage(),
          );
        },
      ),
    );
  }
}


// void main() async {
//   await GetStorage.init();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final box = GetStorage();

//   MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     final taskList = box.read('taskList');

//     final List<Task> list = taskList != null
//         ? List.from((taskList as List<dynamic>).map((e) => Task.fromMap(e)))
//         : [];

//     final taskListProviders = TaskListProviders(taskList: list);

//     print(list);

//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<TaskListProviders>.value(
//             value: taskListProviders)
//       ],
//       child: Builder(
//         builder: (context) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'Flutter Demo',
//             theme: ThemeData(
//               primarySwatch: Colors.purple,
//             ),
//             home: TestScreen(),
//           );
//         },
//       ),
//     );
//   }
// }
