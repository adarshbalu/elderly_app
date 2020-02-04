import 'package:flutter/material.dart';
import 'package:elderly_app/others/constants.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        elevation: 4,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child:
                                Image.asset('lib/resources/images/logo.png')),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          'Elderly ',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 32.0,
                          ),
                        ),
                        Text(
                          'Care',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 32.0,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  ListButtons(
                    icon: Icons.assignment,
                    text: 'Item 1',
                  ),
                  ListButtons(
                    icon: Icons.alarm,
                    text: 'Item 2',
                  ),
                  ListButtons(
                    icon: Icons.assessment,
                    text: 'Item 3',
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  child: Text('Application in Development'),
                  margin: EdgeInsets.all(20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListButtons extends StatelessWidget {
  String text;
  var icon;
  ListButtons({this.text, this.icon});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: kDrawerListStyle,
      ),
      leading: Icon(
        icon,
        size: 37.0,
      ),
    );
  }
}
