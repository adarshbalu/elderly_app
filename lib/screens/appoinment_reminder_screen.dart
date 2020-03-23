import 'package:elderly_app/screens/appoinment_detail_screen.dart';
import 'package:elderly_app/screens/profile_screen.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';

class AppoinmentReminder extends StatefulWidget {
  static const String id = 'Appoinment_Reminder_Screen';
  @override
  _AppoinmentReminderState createState() => _AppoinmentReminderState();
}

class _AppoinmentReminderState extends State<AppoinmentReminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.pushNamed(context, AppoinmentDetail.id);
        },
      ),
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
