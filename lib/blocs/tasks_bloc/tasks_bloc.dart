import 'package:bloc_todo_app/models/task.dart';
import 'package:equatable/equatable.dart';

import '../bloc_exports.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<CompleteTask>(_onCompleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        allTasks: List.from(state.allTasks)..add(event.task),
        activeTasks: List.from(state.activeTasks)..add(event.task),
        favoriteTasks: List.from(state.activeTasks)..add(event.task),
        removedTasks: state.removedTasks,
        completedTasks: state.completedTasks,
      ),
    );
  }

  void _onCompleteTask(CompleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.allTasks.indexOf(task);

    List<Task> allTasks = List.from(state.allTasks)..remove(task);
    task.isDone == false
        ? allTasks.insert(index, task.copyWith(isDone: true))
        : allTasks.insert(index, task.copyWith(isDone: false));

    List<Task> activeTasks = allTasks.where((tsk) {
      return tsk.isDone != true;
    }).toList();

    List<Task> completedTasks = allTasks
        .where(
          (tsk) => tsk.isDone!,
        )
        .toList();

    emit(TasksState(
      allTasks: allTasks,
      activeTasks: activeTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: state.removedTasks,
      completedTasks: completedTasks,
    ));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        allTasks: List.from(state.allTasks)..remove(event.task),
        activeTasks: List.from(state.activeTasks)..remove(event.task),
        favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(
            event.task.copyWith(isDeleted: true),
          ),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
      ),
    );
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        allTasks: List.from(state.allTasks)..remove(event.task),
        activeTasks: state.activeTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: List.from(state.removedTasks)..remove(event.task),
        completedTasks: state.completedTasks,
      ),
    );
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
