// If you get the following error after a pull

//FAILURE: Build failed with an exception.                                                                                         ering with "--enable-software-rendering".
//* What went wrong:
//Execution failed for task ':app:compileFlutterBuildDebug'.
//n\frontend\trayls\build\app\intermediates\flutter\debug\flutter_assets'

//Run the following commands 

//flutter clean
//flutter pub get


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
