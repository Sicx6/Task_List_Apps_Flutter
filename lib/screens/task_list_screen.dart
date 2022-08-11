// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:note_demo/models/task_model.dart';
import 'package:note_demo/providers/task_list_providers.dart';
import 'package:note_demo/providers/users_provider.dart';
import 'package:note_demo/screens/add_task.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TaskListProviders>(
        builder: ((context, value, child) {
          final taskList = value.taskList;
          return Container(
            padding: const EdgeInsets.only(top: 60, right: 25, left: 25),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Tasks List Screen',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: Container()),
                    IconButton(
                      splashRadius: 25,
                      onPressed: () {
                        // getUser();
                        AppUsers().user;
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
                    IconButton(
                      splashRadius: 25,
                      onPressed: () {
                        AppUsers().signOut();
                      },
                      icon: const Icon(
                        Icons.logout,
                        size: 30,
                      ),
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
        }),
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
    return Container(
      padding: const EdgeInsets.all(20),
      height: 140,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(task.description),
              const SizedBox(
                height: 10,
              ),
              Text(task.author),
            ],
          ),
          Expanded(child: Container()),
          const SizedBox(
            width: 10,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () {
                  final taskListProviders =
                      Provider.of<TaskListProviders>(context, listen: false);
                  taskListProviders.deleteTask(index);
                },
                child: const Icon(Icons.delete)),
          ),
        ],
      ),
    );
  }
}
