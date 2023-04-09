import 'package:bloc_todo_app/screens/tasks_screen.dart';
import 'package:bloc_todo_app/services/routes.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/bloc_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(
    MyApp(
      approuter: AppRouter(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter approuter;

  const MyApp({super.key, required this.approuter});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TasksScreen(),
        onGenerateRoute: approuter.onGenerateRoute,
      ),
    );
  }
}
