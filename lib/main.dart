import 'package:final_todo_app/ProviderData/TodoProvider.dart';
import 'package:final_todo_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:final_todo_app/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:final_todo_app/Model/TodoDao.dart';
import 'package:final_todo_app/Model/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt getIt = GetIt.instance;

  getIt.registerSingletonAsync<AppDatabase>(
      () async => $FloorAppDatabase.databaseBuilder('demo.db').build());
  getIt.registerSingletonWithDependencies<TodoDao>(() {
    return GetIt.instance.get<AppDatabase>().todoDao;
  }, dependsOn: [AppDatabase]);
  getIt.registerSingletonWithDependencies<TodoProvider>(() => TodoProvider(),
      dependsOn: [AppDatabase, TodoDao]);
  await getIt.allReady();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoProvider>(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: bgColor,
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
