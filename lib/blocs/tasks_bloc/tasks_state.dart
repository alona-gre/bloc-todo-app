part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> allTasks;
  final List<Task> activeTasks;
  final List<Task> favoriteTasks;
  final List<Task> removedTasks;
  final List<Task> completedTasks;
  const TasksState({
    this.allTasks = const <Task>[],
    this.activeTasks = const <Task>[],
    this.favoriteTasks = const <Task>[],
    this.removedTasks = const <Task>[],
    this.completedTasks = const <Task>[],
  });

  @override
  List<Object> get props =>
      [allTasks, activeTasks, favoriteTasks, removedTasks, completedTasks];

  Map<String, dynamic> toMap() {
    return {
      'allTasks': allTasks.map((x) => x.toMap()).toList(),
      'activeTasks': activeTasks.map((x) => x.toMap()).toList(),
      'favoriteTasks': favoriteTasks.map((x) => x.toMap()).toList(),
      'removedTasks': removedTasks.map((x) => x.toMap()).toList(),
      'completedTasks': completedTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      allTasks: List<Task>.from(
        (map['allTasks']?.map(
          (x) => Task.fromMap(x),
        )),
      ),
      activeTasks: List<Task>.from(
        (map['activeTasks']?.map(
          (x) => Task.fromMap(x),
        )),
      ),
      favoriteTasks: List<Task>.from(
        (map['favoriteTasks']?.map(
          (x) => Task.fromMap(x),
        )),
      ),
      removedTasks: List<Task>.from(
        (map['removedTasks']?.map(
          (x) => Task.fromMap(x),
        )),
      ),
      completedTasks: List<Task>.from(
        (map['completedTasks']?.map(
          (x) => Task.fromMap(x),
        )),
      ),
    );
  }
}
