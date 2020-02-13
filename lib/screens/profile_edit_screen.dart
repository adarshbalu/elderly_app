import 'package:flutter/material.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:elderly_app/others/functions.dart';

class ProfileEdit extends StatefulWidget {
  static const String id = 'profile_edit_screen';
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = getDeviceWidth(context);
    double screenHeight = getDeviceHeight(context);

    return Scaffold(
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
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue.shade50,
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
            Padding(
              padding: EdgeInsets.all(15),
            ),
            Center(
              child: Text(
                'Edit Details',
                style: TextStyle(color: Colors.green, fontSize: 40),
              ),
            )
          ],
        ));
  }
}
