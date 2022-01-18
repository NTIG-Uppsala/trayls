import 'package:flutter/material.dart';

void main() {
  runApp(const Trayls());
}

class Trayls extends StatelessWidget {
  const Trayls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trayls', // Text top page
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(title: 'Trayls'),
    );
  }
}

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
        centerTitle: true,
        foregroundColor: Colors.black,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'HELLO WORLD',
            ),
          ],
        ),
      ),
    );
  }
}
