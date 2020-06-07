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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Elderly '),
            Text(
              'Care',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 1,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProfileScreen.id);
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.perm_identity,
                size: 30,
                color: Color(0xff5e444d),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
