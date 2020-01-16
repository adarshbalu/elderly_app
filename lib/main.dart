import 'package:elderly_app/screens/loading_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(ElderlyApp());

class ElderlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elderly Care',
      home: LoadingScreen(),
    );
  }
}
