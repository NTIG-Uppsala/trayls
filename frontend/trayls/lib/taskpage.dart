import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trayls/api.dart';

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
    task.add(jsonData['task_query']); 
    task.add(jsonData['task_id'].toString()); 
    task.add(jsonData['task_points'].toString()); 
    return task;
  }
 
  //Api api = Api();

  @override
  Widget build(BuildContext context) {
    //print(api);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: const Text("Uppdraget",
            style: TextStyle(fontSize: 50, fontFamily: "")),
      ),
      body: FutureBuilder(
        //FutureBuilder is used to display the data from the API
        future: getTask(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            //If the data is null, it will display a loading screen (waiting for api response)
            return const Center(
              child: Text('Loading...'),
            );
          } else {
            //When the api responds, it will display the data
            return Column(
              //center of the screen
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              snapshot.data[0],
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: "",
                              ),
                            ),
                            Text(
                              "Poäng: " + snapshot.data[2],
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: "",
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
