class Api {
  Api();

  getTask() async {
    var response = await http.get(Uri.http('netlabua.se', '/task'));
    var jsonData = jsonDecode(response.body);

    List<String> task = [];
    task.add(jsonData['task_query']); //Very ugly, but it works
    task.add(jsonData['task_id'].toString()); //Very ugly, but it works
    task.add(jsonData['task_points'].toString()); //Very ugly, but it works
    return task;
  }
}
