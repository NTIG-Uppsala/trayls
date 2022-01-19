import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage(Type string, String s, {Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //We set the Page title
        toolbarHeight: 100,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: const Text("Uppdraget",
            style: TextStyle(fontSize: 50, fontFamily: "")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            SizedBox(
                width: 300.0,
                height: 200.0,
                child: Card(
                  child: Text(
                    'Ditt uppdrag:',
                    style: TextStyle(fontSize: 40, fontFamily: ""),
                  ),
                  color: Color.fromRGBO(76, 175, 80, 1),
                )),
          ],
        ),
      ),
    );
  }
}
