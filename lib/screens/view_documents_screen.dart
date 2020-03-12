import 'dart:io';

import 'package:elderly_app/screens/profile_screen.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewDocuments extends StatefulWidget {
  static const String id = 'View_Documents_Screen';
  @override
  _ViewDocumentsState createState() => _ViewDocumentsState();
}

class _ViewDocumentsState extends State<ViewDocuments> {
  String fileName;
  SharedPreferences prefs;

  initPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  TextEditingController fileNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    initPref();
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
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Add Documents  ',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('File Name : '),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        hintText: 'Enter File name',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.indigo,
                                style: BorderStyle.solid)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Color(0xffaf5676),
                                style: BorderStyle.solid)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Color(0xffaf5676),
                                style: BorderStyle.solid))),
                    onEditingComplete: () async {
                      fileName = fileNameController.text;
                    },
                    onSubmitted: (value) {
                      setState(() {
                        fileName = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          fileName == null
              ? SizedBox(
                  height: 20,
                )
              : CircleAvatar(
                  backgroundImage: FileImage(File(prefs.getString(fileName))),
                  radius: 50,
                  backgroundColor: Colors.white),
        ]));
  }
}
// FileImage(File(prefs.getString('test_image'))
