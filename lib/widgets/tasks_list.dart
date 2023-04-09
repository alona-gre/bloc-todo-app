import 'package:bloc_todo_app/blocs/bloc_exports.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';

class TasksList extends StatelessWidget {
  final List<Task> taskList;

  const TasksList({
    super.key,
    required this.taskList,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          var task = taskList[index];
          return ListTile(
            title: Text(task.title ?? ''),
            trailing: Checkbox(
              value: task.isDone,
              onChanged: (value) {
                context.read<TasksBloc>().add(CompleteTask(task: task));
              },
            ),
            onLongPress: () =>
                context.read<TasksBloc>().add(DeleteTask(task: task)),
          );
        },
      ),
    );
  }
}
