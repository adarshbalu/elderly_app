import 'package:flutter/material.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'profile_screen.dart';

class EditRelativesScreen extends StatefulWidget {
  static const String id = 'Edit_Relatives_Screen';
  @override
  _EditRelativesScreenState createState() => _EditRelativesScreenState();
}

class _EditRelativesScreenState extends State<EditRelativesScreen> {
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
              print('Profile Button Tapped');
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
