import 'package:flutter/material.dart';
import 'package:note_demo/models/task_model.dart';
import 'package:note_demo/providers/task_list_providers.dart';
import 'package:note_demo/providers/users_provider.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descriptionTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, right: 25, left: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              const Text(
                'Add Task',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Expanded(child: Container()),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
            ],
          ),
          Column(
            children: [
              TextField(
                controller: titleTextController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: descriptionTextController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    print(titleTextController.text);
                    print(descriptionTextController.text);

                    final task = Task(
                        title: titleTextController.text,
                        description: descriptionTextController.text,
                        author: AppUsers().user!.email!);

                    Provider.of<TaskListProviders>(context, listen: false)
                        .addTask(task);

                    Navigator.pop(context);
                  },
                  child: const Text('Add Task'),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
