import 'package:flutter/material.dart';

import '../../../blocs/bloc_exports.dart';
import '../../../models/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;
  const EditTaskScreen({
    Key? key,
    required this.oldTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: oldTask.title);
    TextEditingController descriptionController =
        TextEditingController(text: oldTask.description);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        const Text(
          'Edit Task',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: TextField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        TextField(
          autofocus: true,
          controller: descriptionController,
          minLines: 3,
          maxLines: 5,
          decoration: const InputDecoration(
            label: Text('Description'),
            border: OutlineInputBorder(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                var editedTask = Task(
                  title: titleController.text,
                  description: descriptionController.text,
                  id: oldTask.id,
                  isDone: false,
                  isFavorite: oldTask.isFavorite,
                  date: DateTime.now().toString(),
                );
                context.read<TasksBloc>().add(EditTask(
                      oldTask: oldTask,
                      newTask: editedTask,
                    ));
                context.read<TasksBloc>().add(GetAllTasks());
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ]),
    );
  }
}
