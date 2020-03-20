import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'profile_screen.dart';
import 'package:http/http.dart' as http;

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
      body: Column(
        children: <Widget>[
          FlatButton(
            onPressed: () async {
              print('Printed');

//              var url = '{{baseURL}}/api/auth/login';
//              var body = json.encode({
//                'Body=Body of the messageFrom=+917012250352To=+919072122524'
//              });
//              print(body);
//
//              var response = await http.post(
//                'https://api.twilio.com/2010-04-01/Accounts/AC07a649c710761cf3a0e6b96048accf58/Messages.json',
//                headers: {
//                  'accept': 'application/json',
//                },
//                body: body,
              //{
//                    'Body': 'Body of the message',
//                    'From': '+917012250352',
//                    'To': '+919072122524',
//                    'AC07a649c710761cf3a0e6b96048accf58':
//                        'ea627e873b85a03ae83b33a60e657c1d',
              //}
//              );

              //            print(response.body);

//              var uname = 'AC07a649c710761cf3a0e6b96048accf58';
//              var pword = 'ea627e873b85a03ae83b33a60e657c1d';
//              var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));
//
//              var res = await http.post(
//                  'https://api.twilio.com/2010-04-01/Accounts/AC07a649c710761cf3a0e6b96048accf58/Messages.json',
//                  body: body,
//                  headers: {'Authorization': authn});
//              if (res.statusCode != 200) print(res.statusCode);
//              print(res.body);
            },
            child: Text('Text'),
          )
        ],
      ),
    );
  }
}
