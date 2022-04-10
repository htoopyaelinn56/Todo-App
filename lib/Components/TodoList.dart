import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_todo_app/ProviderData/TodoProvider.dart';
import 'package:final_todo_app/Components/TodoCard.dart';
import 'package:get_it/get_it.dart';
import 'package:final_todo_app/Model/Todo.dart';

class TodoList extends StatefulWidget {
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
        stream: GetIt.instance.get<TodoProvider>().getTodoStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('loading');
          }
          List<Todo>? data = snapshot.data;
          return ListView.builder(
            itemBuilder: (context, index) {
              return TodoCard(
                name: data![index].name,
                isChecked: data[index].checked,
                onChanged: (value) {
                  Provider.of<TodoProvider>(context, listen: false)
                      .toggleButton(data[index]);
                  setState(() {});
                },
                deletePress: () {
                  Provider.of<TodoProvider>(context, listen: false)
                      .deleteTodo(data[index]);
                },
                updatePress: () {
                  Provider.of<TodoProvider>(context, listen: false)
                      .updateTodo(data[index], controller.text);
                  setState(() {});
                },
                controller: controller,
                currentText: data[index].name,
              );
            },
            itemCount: data!.length,
          );
        });
  }
}
