import 'package:flutter/material.dart';
import 'package:note_demo/models/task_model.dart';
import 'package:note_demo/providers/task_list_providers.dart';
import 'package:note_demo/providers/users_provider.dart';
import 'package:note_demo/services/api.dart';
import 'package:note_demo/widgets/custom_circular_progress_bar.dart';
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
                  onPressed: () async {
                    try {
                      LoadingIndicator.showLoadingDialog(context);
                      print(titleTextController.text);
                      print(descriptionTextController.text);

                      final task = Task(
                          title: titleTextController.text,
                          description: descriptionTextController.text,
                          author: AppUsers().user!.displayName ?? '');

                      final result = await addTask(task);

                      if (result) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        throw 'Unable to add task';
                      }
                    } catch (e) {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(e.toString()),
                            );
                          });
                    }
                    // Provider.of<TaskListProviders>(context, listen: false)
                    //     .addTask(task);
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
