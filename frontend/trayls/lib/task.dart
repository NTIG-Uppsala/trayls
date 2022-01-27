import 'dart:convert';
import 'dart:async';
import 'package:trayls/api.dart';

class Task {
  String taskQuery = '';
  int taskId = 0;
  int taskPoints = 0;
  String msg = '';

  Task(
      {required this.taskQuery,
      required this.taskId,
      required this.taskPoints});

  Task.completion({required this.msg});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskQuery: json['task_query'],
      taskId: json['task_id'],
      taskPoints: json['task_points'],
    );
  }

  factory Task.msg(String incomingMessage) {
    return Task.completion(msg: incomingMessage);
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

Future<Task> acceptTask(Map<String, dynamic> body) async {
  Api api = Api.body(subdirectory: '/accTask', callBody: body);
  var response = await api.post();
  if (response.statusCode == 200) {
    return Task.msg(response.body);
  } else {
    return Task.msg('Failed to accept task');
  }
}

Future<Task> changeTask(Map<String, dynamic> body) async {
  Api api = Api.body(subdirectory: '/changeTask', callBody: body);
  var response = await api.put(); //TODO: what data is returned?
  print(response.body);
  if (response.statusCode == 200) {
    return Task.msg(response.body);
  } else {
    return Task.msg('Failed to load points'); //ERROR
  }
}
