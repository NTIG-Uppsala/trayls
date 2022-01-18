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
        toolbarHeight: 100,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: Text(widget.title, style: TextStyle(fontSize: 50, fontFamily:"" )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[

              Container(
              margin: EdgeInsets.all(10),
              height: 100.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color.fromRGBO(76, 175, 80, 1))),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SecondPage(),
                  ),
                );
                },
                padding: EdgeInsets.all(10.0),
                color: Color.fromRGBO(76, 175, 80, 1),
                
                child: Text("Nytt uppdrag",
                    style: TextStyle(fontSize: 40)),
              ),
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
        title: Text("Uppdraget", style: TextStyle(fontSize: 50, fontFamily:"" )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[Text('Coolt')],
        ),
      ),
    );
  }
}
