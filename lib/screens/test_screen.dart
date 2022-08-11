import 'package:flutter/material.dart';

import 'package:note_demo/screens/add_task.dart';
import 'package:note_demo/screens/task_list_screen.dart';

class TestScreen extends StatelessWidget {
  TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskListScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
              child: const Text('Home Screen '),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTaskScreen(),
                  ),
                );
              },
              style: TextButton.styleFrom(primary: Colors.deepPurple),
              child: const Text('Login Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
