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

    List<String> task = [];
    task.add(jsonData['task_query']); //Very ugly, but it works
    task.add(jsonData['task_id'].toString()); //Very ugly, but it works
    task.add(jsonData['task_points'].toString()); //Very ugly, but it works
    return task;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uppdrag'),
      ),
      body: Container(
        child: FutureBuilder(
          future: getTask(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: const Center(
                  child: Text('Loading...'),
                ),
              );
            } else {
              return Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      snapshot.data[0],
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Poäng: ${snapshot.data[2]}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
