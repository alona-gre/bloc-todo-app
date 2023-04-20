import 'package:bloc_todo_app/screens/tabs_screen.dart';

import 'package:bloc_todo_app/services/app_theme.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => SwitchBloc()),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            home: const TabsScreen(),
            onGenerateRoute: approuter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
