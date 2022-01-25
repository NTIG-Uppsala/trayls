import 'dart:convert';
import 'dart:async';
import 'package:trayls/api.dart';

class Task {
  final String taskQuery;
  final int taskId;
  final int taskPoints;

  Task(
      {required this.taskQuery,
      required this.taskId,
      required this.taskPoints});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskQuery: json['task_query'],
      taskId: json['task_id'],
      taskPoints: json['task_points'],
    );
  }
}

Future<Task> getTask() async {
  Api api = Api(subdirectory: '/task');
  var response = await api.get();
  if (response.statusCode == 200) {
    return Task.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load task');
  }
}
