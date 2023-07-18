import 'package:equatable/equatable.dart';
import 'package:taskapp/models/task.dart';
import 'package:taskapp/repository/firestore_repository.dart';
import '../bloc_exports.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTask);
    // on<GetAllTasks>(_onGetAllTasks);
    on<GetTodayTasks>(_onGetTodayTasks);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) async {
    await FirestoreRepository.create(task: event.task);
  }

  void _onGetTodayTasks(GetTodayTasks event, Emitter<TasksState> emit) async {
    List<Task> pendingTasks = [];
    List<Task> completedTasks = [];
    List<Task> favoriteTasks = [];
    List<Task> removedTasks = [];
    await FirestoreRepository.getTodayTasks(event.date)
        .then((value) => value.forEach((task) {
              pendingTasks.add(task);
            }));
    await FirestoreRepository.get().then((value) {
      value.forEach((task) {
        if (task.isDeleted == true) {
          removedTasks.add(task);
        } else {
          if (task.isDone == true) {
            completedTasks.add(task);
          }
        }
      });
    });
    emit(TasksState(
        pendingTasks: pendingTasks,
        favoriteTasks: state.favoriteTasks,
        completedTasks: completedTasks,
        removedTasks: removedTasks));
  }
/*
  void _onGetAllTasks(GetAllTasks event, Emitter<TasksState> emit) async {
    List<Task> pendingTasks = [];
    List<Task> completedTasks = [];
    List<Task> favoriteTasks = [];
    List<Task> removedTasks = [];
    await FirestoreRepository.get().then((value) {
      value.forEach((task) {
        if (task.isDeleted == true) {
          removedTasks.add(task);
        } else {
          if (task.isFavorite == true) {
            favoriteTasks.add(task);
          }
          if (task.isDone == true) {
            completedTasks.add(task);
          } else {
            pendingTasks.add(task);
          }
        }
      });
    });
    emit(TasksState(
        removedTasks: removedTasks,
        pendingTasks: pendingTasks,
        favoriteTasks: favoriteTasks,
        completedTasks: completedTasks));
  }*/

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) async {
    Task task = event.task.copyWith(isDone: !event.task.isDone!);
    await FirestoreRepository.update(task: task);
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) async {
    Task removedTask = event.task.copyWith(isDeleted: true);
    await FirestoreRepository.update(task: removedTask);
  }

  void _onMarkFavoriteOrUnfavoriteTask(
      MarkFavoriteOrUnfavoriteTask event, Emitter<TasksState> emit) async {
    Task updatedTask = event.task.copyWith(isFavorite: !event.task.isFavorite!);
    await FirestoreRepository.update(task: updatedTask);
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) async {
    await FirestoreRepository.update(task: event.newTask);
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) async {
    Task removedTask = event.task.copyWith(
        isFavorite: false,
        isDeleted: false,
        isDone: false,
        date: DateTime.now().toString());
    await FirestoreRepository.update(task: removedTask);
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) async {
    Task deletedTask = event.task;
    await FirestoreRepository.delete(task: deletedTask);
  }

  void _onDeleteAllTask(DeleteAllTasks event, Emitter<TasksState> emit) async {
    await FirestoreRepository.deleteAllRemovedTasks(
        taskList: state.removedTasks);
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
