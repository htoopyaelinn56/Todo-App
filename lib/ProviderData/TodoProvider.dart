import 'package:final_todo_app/Model/TodoDao.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../Model/Todo.dart';

class TodoProvider extends ChangeNotifier {
  late TodoDao _dao;
  TodoProvider() {
    _dao = GetIt.instance.get<TodoDao>();
  }

  Future<void> toggleButton(Todo t) async {
    t.toggle();
    notifyListeners();
    await _dao.updateChecked(t.checked ? 1 : 0, t.id!);
  }

  Future<void> addTodo(Todo t) async {
    await _dao.addTodo(t);
    notifyListeners();
  }

  Future<List<Todo>> getTodoList() async {
    return await _dao.getAllList();
  }

  Stream<List<Todo>> getTodoStream() {
    return _dao.getAllListAsStream();
  }

  Future<void> deleteTodo(Todo t) async {
    await _dao.deleteTodo(t);
    notifyListeners();
  }

  Future<void> updateTodo(Todo t, String s) async {
    await _dao.updateTodo(s, t.id!);
  }

  bool currentEditing = false;
}
