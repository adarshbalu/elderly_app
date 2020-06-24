import 'package:elderly_app/models/reminder.dart';
import 'package:elderly_app/others/database_helper.dart';
import 'package:elderly_app/screens/home/home_screen.dart';
import 'package:elderly_app/screens/medicine_reminder/medicine_decision_screen.dart';

import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:elderly_app/others/functions.dart';
import 'reminder_detail.dart';

class MedicineReminder extends StatefulWidget {
  static const String id = 'Medicine_home_screen';
  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  Reminder _reminder = Reminder('', '', '00:00', '00:00', '00:00', 2, 999, {});
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Reminder> reminderList = [];
  int count = 0;
  DateTime dateTime = DateTime.now();
  String today = '';
  Map<int, String> weekDays = {};
  List<Reminder> nearReminders = List<Reminder>();
  List<Reminder> doneReminders = List<Reminder>();
  int weekDayNumber;
  getWeekDays() {
    weekDays = {
      1: 'Mon',
      2: 'Tue',
      3: 'Wed',
      4: 'Thu',
      5: 'Fri',
      6: 'Sat',
      7: 'Sun'
    };
    weekDayNumber = dateTime.weekday;
    today = weekDays[weekDayNumber];
  }

  List<Widget> weekDayWidgets = [];
  List<Widget> getWeekDayWidgets() {
    Widget widget;
    weekDayWidgets = [];
    for (int i = 1; i <= 7; i++) {
      if (i == weekDayNumber) {
        widget = Text(
          weekDays[i].toUpperCase(),
          style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
        );
      } else {
        widget = Text(
          weekDays[i].toUpperCase(),
          style: TextStyle(
            fontSize: 20,
          ),
        );
      }
      weekDayWidgets.add(
          Padding(padding: EdgeInsets.only(left: 2, right: 2), child: widget));
    }
    return weekDayWidgets;
  }

  @override
  void initState() {
    updateListView();
    getWeekDays();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = getDeviceHeight(context);
    if (reminderList == null) {
      reminderList = List<Reminder>();
      updateListView();
    }
    updateListView();
    checkReminders();

    return Scaffold(
      drawer: AppDrawer(),
      appBar: ElderlyAppBar(),
      body: count != 0
          ? WillPopScope(
              onWillPop: () {
                return Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false);
              },
              child: getReminderListView())
          : Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ReminderDetail(_reminder, 'Add Reminder');
                      //return ReminderDetail();
                    }));
                  },
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(40),
                      margin: EdgeInsets.only(
                          bottom: 25,
                          left: 30,
                          right: 30,
                          top: screenHeight * 0.25),
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

  Widget getReminderListView() {
    double width = getDeviceWidth(context);
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 8,
        ),
        nearReminders.length > 0
            ? Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Text(
                      'Medicines in the next few Hours',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: nearReminders.length,
                      itemBuilder: (BuildContext context, int position) {
                        int times = nearReminders[position].times;
                        if (times == 1 &&
                            compareTimes(TimeOfDay.now(),
                                getTimeOfDay(nearReminders[position].time1))) {
                          return Card(
                              margin: EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(nearReminders[position].name),
                                  subtitle: Text(nearReminders[position].time1),
                                  trailing: Icon(
                                    Icons.done,
                                    color: Colors.orange,
                                    size: 35,
                                  ),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return MedicineDecisionScreen(
                                          nearReminders[position]);
                                    }));
                                  },
                                ),
                              ));
                        }
                        if (times == 2) {
                          List<Widget> list = [];
                          if (compareTimes(TimeOfDay.now(),
                              getTimeOfDay(nearReminders[position].time1))) {
                            list.add(Card(
                                margin: EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(nearReminders[position].name),
                                    subtitle:
                                        Text(nearReminders[position].time1),
                                    trailing: Icon(
                                      Icons.done,
                                      color: Colors.orange,
                                      size: 35,
                                    ),
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return MedicineDecisionScreen(
                                            nearReminders[position]);
                                      }));
                                    },
                                  ),
                                )));
                          }
                          if (compareTimes(TimeOfDay.now(),
                              getTimeOfDay(nearReminders[position].time2))) {
                            list.add(Card(
                                margin: EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(nearReminders[position].name),
                                    subtitle:
                                        Text(nearReminders[position].time2),
                                    trailing: Icon(
                                      Icons.done,
                                      color: Colors.orange,
                                      size: 35,
                                    ),
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return MedicineDecisionScreen(
                                            nearReminders[position]);
                                      }));
                                    },
                                  ),
                                )));
                            return Column(
                              children: list,
                            );
                          }
                        }
                        if (times == 3) {
                          List<Widget> list = [];
                          if (compareTimes(TimeOfDay.now(),
                              getTimeOfDay(nearReminders[position].time1))) {
                            list.add(Card(
                                margin: EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(nearReminders[position].name),
                                    subtitle:
                                        Text(nearReminders[position].time1),
                                    trailing: Icon(
                                      Icons.done,
                                      color: Colors.orange,
                                      size: 35,
                                    ),
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return MedicineDecisionScreen(
                                            nearReminders[position]);
                                      }));
                                    },
                                  ),
                                )));
                          }
                          if (compareTimes(TimeOfDay.now(),
                              getTimeOfDay(nearReminders[position].time2))) {
                            list.add(Card(
                                margin: EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(nearReminders[position].name),
                                    subtitle:
                                        Text(nearReminders[position].time2),
                                    trailing: Icon(
                                      Icons.done,
                                      color: Colors.orange,
                                      size: 35,
                                    ),
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return MedicineDecisionScreen(
                                            nearReminders[position]);
                                      }));
                                    },
                                  ),
                                )));
                          }
                          if (compareTimes(TimeOfDay.now(),
                              getTimeOfDay(nearReminders[position].time3))) {
                            list.add(Card(
                                margin: EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(nearReminders[position].name),
                                    subtitle:
                                        Text(nearReminders[position].time3),
                                    trailing: Icon(
                                      Icons.done,
                                      color: Colors.orange,
                                      size: 35,
                                    ),
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return MedicineDecisionScreen(
                                            nearReminders[position]);
                                      }));
                                    },
                                  ),
                                )));
                          }
                          return Column(
                            children: list,
                          );
                        }
                        return SizedBox();
                      }),
                ],
              )
            : Container(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                padding: EdgeInsets.only(top: 15, bottom: 6),
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: getWeekDayWidgets(),
                ),
              ),
        Stack(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height / 1.5),
              margin: EdgeInsets.only(top: 35, left: 10, right: 10, bottom: 0),
              padding: EdgeInsets.only(top: 12, bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overScroll) {
                  overScroll.disallowGlow();
                  return true;
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8),
                  itemCount: count,
                  itemBuilder: (BuildContext context, int position) {
                    return Dismissible(
                      onDismissed: (direction) {
                        _delete(context, this.reminderList[position]);
                        reminderList.removeAt(position);
                        setState(() {
                          _showSnackBar(context, 'Reminder Deleted');
                        });
                      },
                      key: Key(reminderList[position].id.toString()),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(38.0, 26, 38, 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: InkWell(
                              onTap: () {
                                navigateToDetail(this.reminderList[position],
                                    'Edit Reminder');
                              },
                              child: Column(children: <Widget>[
                                Center(
                                  child: Text(
                                    this
                                            .reminderList[position]
                                            .name
                                            .toUpperCase() ??
                                        ' ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      this
                                                  .reminderList[position]
                                                  .times
                                                  .toString() +
                                              ' times' ??
                                          '',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ]),
                            )),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              right: width / 3,
              left: width / 3,
              top: 0,
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ReminderDetail(_reminder, 'Add Reminder');
                    //return ReminderDetail();
                  }));
                },
                child: Material(
                  shape: CircleBorder(),
                  elevation: 5,
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 50,
                    ),
                    radius: 35,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  void _delete(BuildContext context, Reminder reminder) async {
    int result = await databaseHelper.deleteReminder(reminder.id);
    if (result != 0) {
      setState(() {
        updateListView();
      });
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 5),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Reminder reminder, String name) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ReminderDetail(reminder, name);
      //return ReminderDetail();
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Reminder>> remListFuture = databaseHelper.getRemList();
      remListFuture.then((reminderList) {
        setState(() {
          this.reminderList = reminderList;
          this.count = reminderList.length;
        });
      });
    });
  }

  checkReminders() {
    updateListView();
    nearReminders = [];
    TimeOfDay now = TimeOfDay.now();
    TimeOfDay reminderTime;
    for (var reminder in reminderList) {
      if (!(doneReminders.contains(reminder))) {
        if (reminder.times == 1) {
          reminderTime = getTimeOfDay(reminder.time1);
          bool result = compareTimes(now, reminderTime);
          if (result) nearReminders.add(reminder);
        }
        if (reminder.times == 2) {
          reminderTime = getTimeOfDay(reminder.time1);
          bool result = compareTimes(now, reminderTime);
          if (result) nearReminders.add(reminder);
          reminderTime = getTimeOfDay(reminder.time2);
          result = compareTimes(now, reminderTime);
          if (result) nearReminders.add(reminder);
        }
        if (reminder.times == 3) {
          reminderTime = getTimeOfDay(reminder.time1);
          bool result = compareTimes(now, reminderTime);
          if (result) nearReminders.add(reminder);
          reminderTime = getTimeOfDay(reminder.time2);
          result = compareTimes(now, reminderTime);
          if (result) nearReminders.add(reminder);
          reminderTime = getTimeOfDay(reminder.time3);
          result = compareTimes(now, reminderTime);
          if (result) nearReminders.add(reminder);
        }
      }
    }
  }
}

TimeOfDay getTimeOfDay(String time) {
  return TimeOfDay(
      hour: int.parse(time.split(":")[0]),
      minute: int.parse(time.split(":")[1]));
}

compareTimes(TimeOfDay now, TimeOfDay rem) {
  if (toDateTime(now).isBefore(toDateTime(rem))) return true;
  return false;
}

DateTime toDateTime(TimeOfDay time) {
  DateTime now = DateTime.now();
  DateTime dateTime =
      DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return dateTime;
}

double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
