import 'package:final_todo_app/Model/Todo.dart';
import 'package:final_todo_app/ProviderData/TodoProvider.dart';
import 'package:flutter/material.dart';
import 'package:final_todo_app/Components/TodoList.dart';
import 'constants.dart';
import 'package:flutter_text_field_fab/flutter_text_field_fab.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      floatingActionButton: TextFieldFloatingActionButton(
        'Add...',
        Icons.add,
        onChange: (value) {},
        onClear: () async {
          if (controller.text != '') {
            if (!GetIt.instance.get<TodoProvider>().currentEditing) {
              await Provider.of<TodoProvider>(context, listen: false)
                  .addTodo(Todo(name: controller.text));
            } else if (GetIt.instance.get<TodoProvider>().currentEditing) {
              showToast("Can't add item while editing!");
            }
          }
          controller.text = '';
        },
        iconColor: componentColor,
        controller: controller,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: TodoList()),
          ],
        ),
      ),
    );
  }
}
