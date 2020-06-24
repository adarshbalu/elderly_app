import 'package:elderly_app/models/reminder.dart';
import 'package:elderly_app/others/database_helper.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicineDecisionScreen extends StatefulWidget {
  static const String id = 'Medicine_decision_screen';
  final Reminder reminder;
  MedicineDecisionScreen(this.reminder);
  @override
  _MedicineDecisionScreenState createState() => _MedicineDecisionScreenState();
}

class _MedicineDecisionScreenState extends State<MedicineDecisionScreen> {
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
                    onTap: () {
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
                    'If you dont respond within 15 minutes information will be sent to relatives.'))
          ],
        ),
      ),
    );
  }
}
