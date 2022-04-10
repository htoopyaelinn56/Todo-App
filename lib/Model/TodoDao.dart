import 'package:floor/floor.dart';
import 'Todo.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM Todo')
  Future<List<Todo>> getAllList();

  @Query('SELECT * FROM Todo')
  Stream<List<Todo>> getAllListAsStream();

  @insert
  Future<void> addTodo(Todo t);

  @Query('UPDATE Todo SET checked = :checked WHERE id = :id')
  Future<void> updateChecked(int checked, int id);

  @delete
  Future<void> deleteTodo(Todo t);

  @Query('UPDATE Todo Set name = :name WHERE id = :id')
  Future<void> updateTodo(String name, int id);
}
