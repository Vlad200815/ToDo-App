part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends TodoEvent {
  final String taskName;

  const AddTodoEvent({required this.taskName});

  @override
  List<Object> get props => [taskName];
}

class DeleteTodoEvent extends TodoEvent {
  final int index;
  const DeleteTodoEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class CheckTodoEvent extends TodoEvent {
  final Todo task;
  const CheckTodoEvent({required this.task});

  @override
  List<Object> get props => [task];
}

class EditTodoEvent extends TodoEvent {
  final Todo task;

  const EditTodoEvent({required this.task});

  @override
  List<Object> get props => [task];
}
