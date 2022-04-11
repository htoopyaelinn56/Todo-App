import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

@Entity(tableName: 'Todo')
class Todo {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'name')
  final String name;
  bool checked;
  Todo({required this.name, this.checked = false, this.id});
  void toggle() {
    checked = !checked;
  }
}
