import 'package:firebase_auth/todo_app/bloc/todo_bloc.dart';
import 'package:firebase_auth/todo_app/bloc/todo_state.dart';
import 'package:firebase_auth/todo_app/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 255, 134, 64),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Add ToDo",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'task name',
                      ),
                      controller: controller,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        color: Colors.red,
                        focusColor: Colors.white,
                        onPressed: () {
                          var taskName =
                              Todo(task: controller.text, isDone: false);
                          //////////////////////////////////////////////////////////////////////////////////////
                          context
                              .read<TodoBloc>()
                              .add(AddTodoEvent(taskName: taskName.task));
                          Navigator.pop(context);
                          controller.clear();
                        },
                        child: const Text("Add"),
                      ),
                      const SizedBox(width: 14),
                      MaterialButton(
                        color: Colors.amber,
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              final task = state.tasks[index];

              return Padding(
                padding: const EdgeInsets.all(14.0),
                child: ListTile(
                  horizontalTitleGap: 20,
                  contentPadding: const EdgeInsets.all(13),
                  title: Text(
                    task.task.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w500),
                  ),
                  tileColor: Colors.deepPurpleAccent,
                  onLongPress: () {
                    context.read<TodoBloc>().add(DeleteTodoEvent(index: index));
                  },
                  leading: Checkbox(
                    checkColor: Colors.black,
                    activeColor: const Color.fromARGB(255, 255, 255, 255),
                    // fillColor: MaterialStatePropertyAll(Colors.white),
                    onChanged: (value) {
                      context.read<TodoBloc>().add(CheckTodoEvent(task: task));
                    },
                    value: task.isDone,
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: Color.fromARGB(255, 255, 254, 254), width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      context.read<TodoBloc>().add(EditTodoEvent(task: task));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
