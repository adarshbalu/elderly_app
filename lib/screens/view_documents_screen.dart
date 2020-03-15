import 'dart:io';

import 'package:elderly_app/screens/profile_screen.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class ViewDocuments extends StatefulWidget {
  static const String id = 'View_Documents_Screen';
  @override
  _ViewDocumentsState createState() => _ViewDocumentsState();
}

TextEditingController fileNameController = TextEditingController();
String text;

class _ViewDocumentsState extends State<ViewDocuments> {
  String fileName = '';
  bool isFileNameCorrect = false, showImage = false;
  SharedPreferences prefs;
  initPref() async {
    prefs = await SharedPreferences.getInstance();
  }

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
        SizedBox(
          height: 20,
        ),
//        Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: Center(
//            child: Text(
//              'View Documents  ',
//              style: TextStyle(fontSize: 25),
//            ),
//          ),
//        ),
//        SizedBox(
//          height: 20,
//        ),
//        Row(
//          children: <Widget>[
//            Expanded(
//              child: Padding(
//                padding: EdgeInsets.only(left: 8.0),
//                child: Text('File Name : '),
//              ),
//            ),
//            Expanded(
//              flex: 5,
//              child: Padding(
//                padding: const EdgeInsets.all(20.0),
//                child: TextField(
//                  style: TextStyle(fontSize: 20),
//                  decoration: InputDecoration(
//                      suffixIcon: isFileNameCorrect
//                          ? Icon(
//                              Icons.check,
//                              color: Colors.green,
//                            )
//                          : Icon(
//                              Icons.error_outline,
//                              color: Colors.red,
//                            ),
//                      hintText: 'Enter File name',
//                      helperText: isFileNameCorrect ? '' : 'Wrong Name',
//                      helperStyle: TextStyle(color: Colors.red),
//                      focusedBorder: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(30),
//                          borderSide: BorderSide(
//                              color: Colors.indigo, style: BorderStyle.solid)),
//                      enabledBorder: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(30),
//                          borderSide: BorderSide(
//                              color: Colors.blue, style: BorderStyle.solid)),
//                      border: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(30),
//                          borderSide: BorderSide(
//                              color: Color(0xffaf5676),
//                              style: BorderStyle.solid))),
//                  onChanged: (value) {
//                    for (var file in prefs.getKeys()) {
//                      if (file == value) {
//                        setState(() {
//                          fileName = value;
//                        });
//                      }
//                    }
//                    print('submitted' + fileName);
//                    setState(() {
//                      if (fileName == value) {
//                        isFileNameCorrect = true;
//                        showImage = true;
//                      } else {
//                        fileName = ' ';
//                        isFileNameCorrect = false;
//                      }
//                    });
//                  },
//                ),
//              ),
//            ),
//          ],
//        ),
//        !showImage
//            ? SizedBox(
//                height: 20,
//              )
//            : Container(
//                margin: EdgeInsets.all(20),
//                child: Text(
//                  'Name : ' + fileName,
//                  style: TextStyle(fontSize: 30),
//                  textAlign: TextAlign.center,
//                ),
//              ),
//        !showImage
//            ? SizedBox(
//                height: 20,
//              )
//            : Container(
//                child: SizedBox(),
//              ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'All Documents available : ',
            style: TextStyle(fontSize: 25),
          ),
        ),
        Builder(),
        SizedBox(
          height: 100,
        )
      ]),
    );
  }
}
// FileImage(File(prefs.getString('test_image'))

//CircleAvatar(
//backgroundImage: FileImage(File(prefs.getString(fileName))),
//radius: 50,
//backgroundColor: Colors.white),

class Builder extends StatelessWidget {
  Future<List<Widget>> getAllPrefs(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .getKeys()
        .map<Widget>(
          (key) => Image.file(
            prefs.get(key),
            height: 300,
            width: 300,
          ),
        )
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
        future: getAllPrefs(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          return Column(
            children: snapshot.data,
          );
        });
  }
}
