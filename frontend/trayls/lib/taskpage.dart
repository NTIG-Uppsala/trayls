//Take a task form the API http://netlabua.se/task
//Swap the text with the task from the API

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
//import http package
import 'package:http/http.dart' as http;

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  getTask() async {
    var response = await http.get(Uri.http('netlabua.se', '/task'));
    var jsonData = jsonDecode(response.body);
    Task task = Task(
      jsonData['task_query'],
      jsonData['task_id'],
      jsonData['task_points'],
    );
    return task;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uppdrag'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Uppdrag',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              getTask(),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  final String task_query, task_id, task_points;
  Task(this.task_query, this.task_id, this.task_points);
}
