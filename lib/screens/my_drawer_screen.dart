import 'package:bloc_todo_app/screens/deleted_tasks_screen.dart';
import 'package:bloc_todo_app/screens/tasks_screen.dart';
import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import 'completed_tasks_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 40,
            color: Colors.black26,
          ),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              color: Colors.black26,
              child: const Text(
                'Task Drawer',
                style: TextStyle(fontSize: 20),
              )),
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pushReplacementNamed(
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
                onTap: () => Navigator.of(context).pushReplacementNamed(
                  CompletedTasksScreen.id,
                ),
                child: ListTile(
                  leading: const Icon(Icons.folder_special),
                  title: const Text('Completed tasks'),
                  trailing: Text(
                      '${state.completedTasks.isNotEmpty ? state.completedTasks.length : 0}'),
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
                onTap: () => Navigator.of(context).pushReplacementNamed(
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
          BlocBuilder<SwitchBloc, SwitchState>(
            builder: (context, state) {
              return Switch(
                value: state.switchValue,
                onChanged: (newValue) {
                  newValue
                      ? context.read<SwitchBloc>().add(SwitchOnEvent())
                      : context.read<SwitchBloc>().add(SwitchOffEvent());
                },
              );
            },
          )
        ],
      ),
    );
  }
}
