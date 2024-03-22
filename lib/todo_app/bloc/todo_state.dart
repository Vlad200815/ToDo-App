import 'package:equatable/equatable.dart';
import 'package:firebase_auth/todo_app/model/todo_model.dart';

// part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final List<Todo> tasks;

  const TodoState({
    required this.tasks,
  });

  @override
  List<Object> get props => [tasks];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tasks': tasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TodoState.fromMap(Map<String, dynamic> map) {
    return TodoState(
      tasks: List<Todo>.from(
        (map['tasks'] as List<dynamic>).map<Todo>(
          (x) => Todo.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
