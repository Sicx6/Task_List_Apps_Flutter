// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_demo/models/task_model.dart';
import 'package:note_demo/providers/task_list_providers.dart';
import 'package:note_demo/providers/users_provider.dart';
import 'package:note_demo/screens/add_task.dart';
import 'package:note_demo/screens/edit_task.dart';
import 'package:note_demo/services/api.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Task>>(
        stream: getTaskListStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Task> taskList = snapshot.data!;
            return Container(
              padding: const EdgeInsets.only(top: 60, right: 25, left: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Tasks List Screen',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        splashRadius: 25,
                        onPressed: () {
                          AppUsers.instance.signOut();
                        },
                        icon: const Icon(
                          Icons.logout,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        splashRadius: 25,
                        onPressed: () {
                          // getUser();
                          AppUsers.instance.user;
                          print(AppUsers().user);
                        },
                        icon: const Icon(
                          Icons.person,
                          size: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        ...List.generate(
                          taskList.length,
                          (index) {
                            return TaskContainer(
                                index: index, task: taskList[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => AddTaskScreen())));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskContainer extends StatelessWidget {
  const TaskContainer({
    Key? key,
    required this.task,
    required this.index,
  }) : super(key: key);

  final Task task;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        task.completed = !task.completed;
        updateTask(task);
      },
      onLongPress: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EditTaskScreen(
            task: task,
          );
        }));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(5, 5))
            ]),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      color: task.completed ? Colors.purple : Colors.redAccent,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      decoration:
                          task.completed ? null : TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(task.description),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(task.author),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    task.dateInString,
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            const SizedBox(
              width: 10,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () async {
                    try {
                      // final taskListProviders =
                      //     Provider.of<TaskListProviders>(context, listen: false);
                      // taskListProviders.deleteTask(index);
                      // await deleteTask('taskId');
                      print(task.id);
                      if (task.id != null) {
                        await deleteTask(task.id!);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Icon(Icons.delete)),
            ),
          ],
        ),
      ),
    );
  }
}
