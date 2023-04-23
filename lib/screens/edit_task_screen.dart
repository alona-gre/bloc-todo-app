import 'package:bloc_todo_app/blocs/bloc_exports.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;
  const EditTaskScreen({
    Key? key,
    required this.oldTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(
      text: oldTask.title,
    );
    TextEditingController notesController = TextEditingController(
      text: oldTask.notes,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Edit task',
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
            controller: notesController,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              label: Text('Notes'),
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
                      notes: notesController.text,
                      id: oldTask.id,
                      isFavorite: oldTask.isFavorite,
                      isDone: false,
                      createdDate: DateTime.now().toString());
                  context.read<TasksBloc>().add(
                        EditTask(
                          oldTask: oldTask,
                          newTask: editedTask,
                        ),
                      );
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
