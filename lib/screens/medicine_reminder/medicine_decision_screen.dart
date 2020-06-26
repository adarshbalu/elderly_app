import 'dart:convert';

import 'package:elderly_app/models/reminder.dart';
import 'package:elderly_app/others/database_helper.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class MedicineDecisionScreen extends StatefulWidget {
  static const String id = 'Medicine_decision_screen';
  final Reminder reminder;
  MedicineDecisionScreen(this.reminder);
  @override
  _MedicineDecisionScreenState createState() => _MedicineDecisionScreenState();
}

class _MedicineDecisionScreenState extends State<MedicineDecisionScreen> {
  sendSms() async {
    var cred =
        'AC07a649c710761cf3a0e6b96048accf58:60cfd08bcc74ea581187a048dfd653cb';

    var bytes = utf8.encode(cred);

    var base64Str = base64.encode(bytes);

    var url =
        'https://api.twilio.com/2010-04-01/Accounts/AC07a649c710761cf3a0e6b96048accf58/Messages.json';

    var response = await http.post(url, headers: {
      'Authorization': 'Basic $base64Str'
    }, body: {
      'From': '+12567403927',
      'To': '+918078214942',
      'Body': 'Just forgot to take medicine now'
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ElderlyAppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Did you take ${widget.reminder.name} ?',
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
                      Reminder r = widget.reminder;
                      DateTime now = DateTime.now();

                      String dateString =
                          (DateFormat('yyyy-MM-dd hh:mm').format(now));

                      r.intakeHistory.addAll({
                        dateString: {TimeOfDay.now().toString(): true}
                      });

                      databaseHelper.updateReminder(r);
                      setState(() {});
                      Navigator.pop(context);
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
                    onTap: () async {
                      Reminder r = widget.reminder;
                      DateTime now = DateTime.now();

                      String dateString =
                          (DateFormat('yyyy-MM-dd hh:mm').format(now));

                      r.intakeHistory.addAll({
                        dateString: {TimeOfDay.now().toString(): false}
                      });
                      print(r.intakeHistory);
                      databaseHelper.updateReminder(r);
                      setState(() {});
                      await sendSms();
                      Navigator.pop(context);
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
                    'Negative response information will be sent to relatives.'))
          ],
        ),
      ),
    );
  }
}
