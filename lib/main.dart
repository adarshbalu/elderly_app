import 'package:elderly_app/screens/home_screen.dart';
import 'package:elderly_app/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(ElderlyApp());

class ElderlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elderly Care',
      home: HomeScreen(),
    );
  }
}
