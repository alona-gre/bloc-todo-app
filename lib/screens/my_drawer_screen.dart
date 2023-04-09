import 'package:bloc_todo_app/screens/deleted_tasks_screen.dart';
import 'package:bloc_todo_app/screens/tasks_screen.dart';
import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                color: Colors.grey,
                child: const Text(
                  'Task Drawer',
                  style: TextStyle(fontSize: 20),
                )),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                    TasksScreen.id,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.folder_special),
                    title: const Text('All tasks'),
                    trailing: Text('${state.allTasks.length}'),
                  ),
                );
              },
            ),
            const Divider(
              height: 10,
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                    DeletedTasksScreen.id,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.folder_special),
                    title: const Text('Recently deleted'),
                    trailing: Text(
                        '${state.removedTasks.isNotEmpty ? state.removedTasks.length : 0}'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
