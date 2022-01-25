import 'package:flutter/material.dart';
import 'package:trayls/task.dart';
import 'dart:async';
import 'package:trayls/homepage.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late Future<Task> futureTask;
  @override
  void initState() {
    super.initState();
    futureTask = getTask();
  }

  @override
  Widget build(BuildContext context) {
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
        future: futureTask,
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
                              snapshot.data.taskQuery,
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: "",
                              ),
                            ),
                            Text(
                              "Poäng: ${snapshot.data.taskPoints}",
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.black,
                    minimumSize: const Size(240, 80),
                    maximumSize: const Size(720, 240),
                  ),
                  child: const Text("Klar",
                      style: TextStyle(
                        fontSize: 40,
                      )),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const TaskPage(),
                          transitionDuration: const Duration(seconds: 0)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.black,
                    minimumSize: const Size(240, 80),
                    maximumSize: const Size(720, 240),
                  ),
                  child: const Text("Skippa",
                      style: TextStyle(
                        fontSize: 40,
                      )),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
