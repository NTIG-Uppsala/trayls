import 'package:flutter/material.dart';
import 'package:trayls/homepage.dart';
import 'package:trayls/task.dart';
import 'dart:async';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late Future<Task> futureTask;
  late Future<Task> futureAcceptTask;
  late Future<Task> futureCompleteTask;

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
                        width: 300,
                        height: 120,
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
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await acceptTask({
                          'mail': 'genericuser@mail.com',
                          'task_id': snapshot.data.taskId.toString()
                        });
                        await changeTask(
                            {'mail': 'genericuser@mail.com', 'status': '2'});
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HomePage(title: 'Trayls')));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.black,
                        minimumSize: const Size(300, 120),
                        maximumSize: const Size(840, 280),
                      ),
                      child: const Text("Klar",
                          style: TextStyle(
                            fontSize: 40,
                          )),
                    ),
                    const SizedBox(height: 20),
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
                        minimumSize: const Size(300, 120),
                        maximumSize: const Size(840, 280),
                      ),
                      child: const Text("Skippa",
                          style: TextStyle(
                            fontSize: 40,
                          )),
                    ),
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
