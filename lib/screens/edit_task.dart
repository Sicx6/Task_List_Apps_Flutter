import 'package:flutter/material.dart';
import 'package:note_demo/models/task_model.dart';
import 'package:note_demo/providers/task_list_providers.dart';
import 'package:note_demo/providers/users_provider.dart';
import 'package:note_demo/services/api.dart';
import 'package:note_demo/widgets/custom_circular_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditTaskScreen extends StatelessWidget {
  EditTaskScreen({Key? key, required this.task}) : super(key: key);

  final Task task;

  final titleController = TextEditingController();
  final descriptionTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = task.title;
    descriptionTitleController.text = task.description;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, right: 25, left: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              const Text(
                'Edit Task',
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
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'title',
                ),
              ),
              TextField(
                controller: descriptionTitleController,
                decoration: const InputDecoration(
                  labelText: 'description',
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

                      task.title = titleController.text;
                      task.description = descriptionTitleController.text;

                      // final _task = Task(
                      //     title: titleController.text,
                      //     description: descriptionTitleController.text,
                      //     author: task.author,
                      //     createdDate: task.createdDate,
                      //     authorId: task.authorId);

                      final result = await updateTask(task);

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
                  child: const Text('Update Task'),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
