import 'dart:convert';
import 'package:http/http.dart' as http;

class Task {
  final String taskQuery;
  final int taskId;
  final int taskPoints;

  const Task(
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
  var response = await http.get(Uri.http('netlabua.se', '/task'));

  if (response.statusCode == 200) {
    print(response);
    return Task.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load task');
  }
}
