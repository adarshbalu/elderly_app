import 'package:elderly_app/screens/profile/profile_screen.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';

class AddRelative extends StatefulWidget {
  final String documentID;
  AddRelative(this.documentID);
  @override
  _AddRelativeState createState() => _AddRelativeState();
}

class _AddRelativeState extends State<AddRelative> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: ElderlyAppBar(),
    );
  }
}
