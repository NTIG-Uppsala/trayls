import 'package:flutter/material.dart';
import 'package:trayls/taskpage.dart';
import 'package:trayls/points.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Points> futurePoints;
  @override
  void initState() {
    super.initState();
    futurePoints = getPoints({'mail': 'genericuser@mail.com'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //We set the Page title
        toolbarHeight: 100,
        centerTitle: true,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(widget.title,
            style: const TextStyle(fontSize: 50, fontFamily: "")),
      ),
      body: FutureBuilder(
        //FutureBuilder is used to display the data from the API
        future: futurePoints,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            //If the data is null, it will display a loading screen (waiting for api response)
            return const Center(
              child: Text('Loading...'),
            );
          } else {
            //When the a
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        snapshot.data.points.toString(),
                        style: const TextStyle(
                          fontSize: 100,
                          fontFamily: "",
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 75),
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
                const SizedBox(height: 75),
              ],
            );
          }
        },
      ),
    );
  }
}
