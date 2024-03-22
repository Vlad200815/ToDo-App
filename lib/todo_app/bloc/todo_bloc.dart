import 'package:equatable/equatable.dart';
import 'package:firebase_auth/todo_app/bloc/todo_state.dart';
import 'package:firebase_auth/todo_app/model/todo_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'todo_event.dart';
// part 'todo_state.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState(tasks: <Todo>[])) {
    on<AddTodoEvent>((event, emit) {
      final state = this.state;
      if (event.taskName.length < 4) {
        return;
      } else {
        emit(
          TodoState(
            tasks: List.from(state.tasks)
              ..add(
                Todo(task: event.taskName, isDone: false),
              ),
          ),
        );
      }
    });
    on<DeleteTodoEvent>((event, emit) {
      final state = this.state;
      emit(
        TodoState(
          tasks: List.from(state.tasks)..removeAt(event.index),
        ),
      );
    });

    on<CheckTodoEvent>((event, emit) {
      final state = this.state;
      final task = event.task;
      final int index = state.tasks.indexOf(task);
      List<Todo> tasks = List.from(state.tasks)..remove(task);

      task.isDone == false
          ? tasks.insert(index, task.copyWith(isDone: true))
          : tasks.insert(index, task.copyWith(isDone: false));

      emit(TodoState(tasks: tasks));
    });
    //Edit
    on<EditTodoEvent>((event, emit) {
      final state = this.state;
    });

    //Favorite start feature

    //Add Timer to each todos

    //Cool delete animation with sladeble

    //New beutyfull design

    //Smart sistem for maneging
  }

  @override
  TodoState fromJson(Map<String, dynamic> json) {
    return TodoState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TodoState state) {
    return state.toMap();
  }
}
