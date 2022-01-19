import 'package:flutter/material.dart';
import 'package:trayls/taskpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //We set the Page title
        toolbarHeight: 100,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: Text(widget.title,
            style: const TextStyle(fontSize: 50, fontFamily: "")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TaskPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.black,
                minimumSize: const Size(240, 80),
                maximumSize: const Size(720, 240),
              ),
              child: const Text("Nytt uppdrag",
                  style: TextStyle(
                    fontSize: 40,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
