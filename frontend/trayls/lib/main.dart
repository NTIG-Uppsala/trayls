import 'package:flutter/material.dart';
import 'package:trayls/homepage.dart';

void main() {
  runApp(const Trayls());
}

class Trayls extends StatelessWidget {
  const Trayls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trayls',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(title: 'Trayls'),
    );
  }
}
