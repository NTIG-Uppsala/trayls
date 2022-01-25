import 'dart:convert';
import 'package:http/http.dart' as http;
class Api {
  List<String> taskResponse = [];
  Api() {
    taskResponse = getTask();
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
}
