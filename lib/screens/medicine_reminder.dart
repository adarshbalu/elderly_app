import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'package:elderly_app/others/functions.dart';

class MedicineReminder extends StatefulWidget {
  static const String id = 'Medicine_Screen';
  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = getDeviceWidth(context);
    double screenHeight = getDeviceHeight(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Pressed');
        },
        backgroundColor: Color(0xffE3952D),
        child: Icon(Icons.add),
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
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(40),
              margin: EdgeInsets.only(
                  bottom: 25, left: 30, right: 30, top: screenHeight * 0.25),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    offset: Offset(0, 8.0),
                  ),
                ],
              ),
              child: Icon(
                Icons.add,
                size: 40,
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Text(
                'Click to add Reminder',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffE3952D),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
