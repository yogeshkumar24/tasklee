import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:tasklee/task/provider/provider.dart';
import 'package:tasklee/task/repository/task_repository.dart';
import 'package:tasklee/task/service/task_api_service.dart';
import 'package:tasklee/task/service/task_db_service.dart';
import 'core/core.dart';

///PLEASE READ README.md file
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providerInit(),
      child: MaterialApp(
        title: AppText.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
          useMaterial3: true,
        ),
        routes: routes,
        initialRoute: AppRoutes.listTask,
      ),
    );
  }

  List<SingleChildWidget> providerInit() {
    return [
      ChangeNotifierProvider(create: (context) {
        final taskRepository = TaskRepository(
          taskApiService: TaskApiService(),
          taskDBService: TaskDBService(),
        );
        return TaskProvider(taskRepository)..fetchTask();
      })
    ];
  }
}
