import 'package:elderly_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppoinmentDecision extends StatefulWidget {
  static const String id = 'Appoinment_decision_screen';
  @override
  _AppoinmentDecisionState createState() => _AppoinmentDecisionState();
}

class _AppoinmentDecisionState extends State<AppoinmentDecision> {
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Did you visit doctor ?',
                style: TextStyle(fontSize: 30, color: Colors.blue),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.check,
                          size: 90,
                          color: Colors.white,
                        )),
                    onTap: () {
                      print('true');
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.close,
                          size: 90,
                          color: Colors.white,
                        )),
                    onTap: () {
                      print('false');
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                    'If you dont respond within 15 minutes information will be sent to relatives.'))
          ],
        ),
      ),
    );
  }
}
