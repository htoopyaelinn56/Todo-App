// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TodoDao? _todoDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Todo` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `checked` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }
}

class _$TodoDao extends TodoDao {
  _$TodoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _todoInsertionAdapter = InsertionAdapter(
            database,
            'Todo',
            (Todo item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'checked': item.checked ? 1 : 0
                },
            changeListener),
        _todoDeletionAdapter = DeletionAdapter(
            database,
            'Todo',
            ['id'],
            (Todo item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'checked': item.checked ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Todo> _todoInsertionAdapter;

  final DeletionAdapter<Todo> _todoDeletionAdapter;

  @override
  Future<List<Todo>> getAllList() async {
    return _queryAdapter.queryList('SELECT * FROM Todo',
        mapper: (Map<String, Object?> row) => Todo(
            name: row['name'] as String,
            checked: (row['checked'] as int) != 0,
            id: row['id'] as int?));
  }

  @override
  Stream<List<Todo>> getAllListAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Todo',
        mapper: (Map<String, Object?> row) => Todo(
            name: row['name'] as String,
            checked: (row['checked'] as int) != 0,
            id: row['id'] as int?),
        queryableName: 'Todo',
        isView: false);
  }

  @override
  Future<void> updateChecked(int checked, int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Todo SET checked = ?1 WHERE id = ?2',
        arguments: [checked, id]);
  }

  @override
  Future<void> updateTodo(String name, int id) async {
    await _queryAdapter.queryNoReturn('UPDATE Todo Set name = ?1 WHERE id = ?2',
        arguments: [name, id]);
  }

  @override
  Future<void> addTodo(Todo t) async {
    await _todoInsertionAdapter.insert(t, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTodo(Todo t) async {
    await _todoDeletionAdapter.delete(t);
  }
}
