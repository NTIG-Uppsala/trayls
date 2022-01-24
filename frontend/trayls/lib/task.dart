import 'dart:convert';
import 'package:http/http.dart' as http;


class Task {
  final String taskQuery;
  final int taskId;
  final int taskPoints;

  const Task({
    required this.taskQuery,
    required this.taskId,
    required this.taskPoints
  })

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskQuery: json['task_query'],
      taskId: json['task_id'],
      taskPoints: json['task_points'],
    );
  }
}

getTask() async {
    var response = await http.get(Uri.http('netlabua.se', '/task'));
    var jsonData = jsonDecode(response.body);

    List<String> task = [];
    task.add(jsonData['task_query']); 
    task.add(jsonData['task_id'].toString()); 
    task.add(jsonData['task_points'].toString()); 
    return task;
  }
