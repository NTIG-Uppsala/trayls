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
    final ButtonStyle test = ElevatedButton.styleFrom();
    return Scaffold(
      appBar: AppBar(
        //We set the Page title
        toolbarHeight: 100,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: Text(widget.title, style: TextStyle(fontSize: 50, fontFamily:"" )),
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
                    builder: (context) => const SecondPage(),
                  ),
                );
                },
                style: ElevatedButton.styleFrom(primary: Colors.green, onPrimary: Colors.black, minimumSize: const Size(240, 80), maximumSize: const Size(720, 240),),
                child: const Text("Nytt uppdrag",
                    style: TextStyle(fontSize: 40, )),
              ),
          ],
        ),
      ),
    );
  }
}
class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //We set the Page title
        toolbarHeight: 100,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: const Text("Uppdraget", style: TextStyle(fontSize: 50, fontFamily:"" )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                width: 300.0,
                height: 200.0,
                child: Card(child: Text('Ditt uppdrag:', style: TextStyle(fontSize: 40, fontFamily:""),), color: Color.fromRGBO(76, 175, 80, 1),)
            ),
          ],
        ),
      ),
    );
  }
}
