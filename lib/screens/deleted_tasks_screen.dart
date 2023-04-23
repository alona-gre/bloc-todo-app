import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../widgets/tasks_list.dart';
import 'my_drawer_screen.dart';

class DeletedTasksScreen extends StatelessWidget {
  const DeletedTasksScreen({super.key});

  static const id = 'deleted_tasks_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.removedTasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Deleted Tasks'),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: () => context.read<TasksBloc>().add(
                            DeleteAllTasks(),
                          ),
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Delete all tasks'),
                    ),
                    onTap: () => context.read<TasksBloc>().add(
                          DeleteAllTasks(),
                        ),
                  ),
                ],
              ),
            ],
          ),
          drawer: const MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Chip(
                  label: Text('Tasks'),
                ),
              ),
              TasksList(taskList: taskList),
            ],
          ),
        );
      },
    );
  }
}
