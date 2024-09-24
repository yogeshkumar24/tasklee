import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasklee/core/app_constants.dart';
import 'package:tasklee/task/provider/provider.dart';
import 'package:tasklee/task/service/task_api_service.dart';

import 'task/view/screen/task_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context){
          return TaskProvider(TaskApiService());
        })
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TaskListScreen(),
      ),
    );
  }
}
