//Take a task form the API http://netlabue.se/task
//Swap the text with the task from the API

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
  @override
  Widget build(BuildContext context) {
    Future<String> hej = getTask().then((value) => value);
    return Scaffold(
      appBar: AppBar(
        title: Text('Task'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Task',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              hej.asStream().toString(),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

//api call
  Future<String> getTask() async {
    //return the task_query from the API response
    await http.get(Uri.parse('http://netlabua.se/task')).then((response) async {
      if (response.statusCode == 200) {
        final String res = await response.body;
        return res;
      } else {
        throw HttpException('Unexpected status code ${response.statusCode}:'
            ' ${response.reasonPhrase}');
      }
    });
    return 'ERROR';
  }
}
