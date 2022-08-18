import 'package:flutter/material.dart';
import 'package:note_demo/models/task_model.dart';
import 'package:note_demo/providers/task_list_providers.dart';
import 'package:note_demo/providers/users_provider.dart';
import 'package:note_demo/services/api.dart';
import 'package:note_demo/widgets/custom_circular_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  final form = FormGroup({
    'title':
        FormControl(validators: [Validators.required, Validators.minLength(3)]),
    'description':
        FormControl(validators: [Validators.required, Validators.minLength(5)]),
  });

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
          ReactiveForm(
            formGroup: form,
            child: Column(
              children: [
                ReactiveTextField(
                  formControlName: 'title',
                  decoration: const InputDecoration(
                    labelText: 'title',
                  ),
                  validationMessages: {
                    ValidationMessage.minLength: (error) =>
                        'Please insert you proper task title'
                  },
                ),
                ReactiveTextField(
                  formControlName: 'description',
                  decoration: const InputDecoration(
                    labelText: 'description',
                  ),
                  validationMessages: {
                    ValidationMessage.minLength: (error) =>
                        'Please insert you proper task description'
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ReactiveFormConsumer(builder: ((context, formGroup, child) {
                  return Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: form.valid
                          ? () async {
                              try {
                                LoadingIndicator.showLoadingDialog(context);

                                final task = Task(
                                    title: form.control('title').value,
                                    description:
                                        form.control('description').value,
                                    author:
                                        AppUsers.instance.user!.displayName ??
                                            '',
                                    createdDate: DateTime.now());

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
                            }
                          : null,
                      child: const Text('Add Task'),
                    ),
                  );
                }))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
