// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String task;
  bool? isDone;
  bool? isFavorite;

  Todo({
    required this.task,
    this.isDone,
  }) {
    isDone = isDone ?? false;
    isFavorite = isFavorite ?? false;
  }
  Todo copyWith({String? title, bool? isDone, bool? isFavorite}) {
    return Todo(
      task: task ?? this.task,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props => [task, isDone, isFavorite];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task': task,
      'isDone': isDone,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      task: map['task'] as String,
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
    );
  }
}
