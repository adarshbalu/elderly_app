import 'dart:math';

import 'package:elderly_app/models/appoinment.dart';
import 'package:elderly_app/others/database_helper.dart';
import 'package:elderly_app/screens/appoinment_reminder/appoinment_decision_screen.dart';
import 'package:elderly_app/screens/appoinment_reminder/appoinment_detail_screen.dart';
import 'package:elderly_app/screens/home/home_screen.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class AppoinmentReminder extends StatefulWidget {
  static const String id = 'Appoinment_Reminder_Screen';
  @override
  _AppoinmentReminderState createState() => _AppoinmentReminderState();
}

class _AppoinmentReminderState extends State<AppoinmentReminder> {
  var rng = Random();
  var kTextStyle =
      TextStyle(color: Colors.brown, fontSize: 15, fontWeight: FontWeight.w700);
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Appoinment> appoinmentList;
  Appoinment appoinment;
  int count = 0;
  int tempDay, tempMonth, tempYear, tempHour, tempMinute;

  DateTime dateTime = DateTime.now();
  String year = DateTime.now().year.toString();
  String month = '';
  Map<int, String> months = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };

  getMonth() {
    int monthDay = dateTime.month;
    month = months[monthDay];
  }

  DateTime today = DateTime.now();

  final f = DateFormat('yyyy-MM-dd hh:mm');
  @override
  void initState() {
    todayAppoinment = [];
    upcomingAppoinment = [];
    pastAppoinment = [];
    appoinment = Appoinment(
        '',
        '',
        DateTime(0000, 00, 00, 00, 00, 00).toString(),
        '',
        rng.nextInt(99999),
        false);
    getMonth();
    getTextWidgets();

    super.initState();
  }

  List<Widget> textWidgets = [];

  getTextWidgets() {
    int month = dateTime.month;
    int year = dateTime.year;
    int day = dateTime.day;
    int endDay;
    if (month == 1 ||
        month == 3 ||
        month == 5 ||
        month == 7 ||
        month == 8 ||
        month == 12 ||
        month == 10) {
      endDay = 31;
    } else if (month == 2) {
      if (year % 4 == 0)
        endDay = 29;
      else
        endDay = 28;
    } else {
      endDay = 30;
    }
    Widget today = CircleAvatar(
      child: Text(
        day.toString(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.blue,
    );
    int start = 1;
    for (var i = day; i <= day + 4; i++) {
      if (i > endDay) {
        textWidgets.add(Text(start.toString()));
        start++;
      } else {
        if (i == day)
          textWidgets.add(today);
        else
          textWidgets.add(Text(i.toString()));
      }
    }
  }

  List<Appoinment> todayAppoinment;
  List<Appoinment> upcomingAppoinment;
  List<Appoinment> pastAppoinment;

  Future getTodayAppoinment() async {
    setState(() {
      todayAppoinment = [];
      for (Appoinment tempAppoinment in appoinmentList) {
        DateTime date = DateTime.parse(tempAppoinment.dateAndTime);

        if (today.day == date.day &&
            today.month == date.month &&
            today.year == date.year &&
            !tempAppoinment.done) {
          todayAppoinment.add(tempAppoinment);
        }
      }
    });
  }

  Future getUpcomingAppoinment() async {
    setState(() {
      upcomingAppoinment = [];

      for (Appoinment tempAppoinment in appoinmentList) {
        DateTime date = DateTime.parse(tempAppoinment.dateAndTime);

        if (!todayAppoinment.contains(tempAppoinment)) {
          if (today.isBefore(date)) {
            upcomingAppoinment.add(tempAppoinment);
          }
        }
      }
    });
  }

  Future getPastAppoinment() async {
    setState(() {
      pastAppoinment = [];

      for (Appoinment tempAppoinment in appoinmentList) {
        DateTime date = DateTime.parse(tempAppoinment.dateAndTime);

        if (date.isBefore(today) && !todayAppoinment.contains(tempAppoinment)) {
          pastAppoinment.add(tempAppoinment);
        }
      }
    });
  }

  List<Widget> getPastAppoinmentWidget(BuildContext context) {
    pastAppoinment.sort((a, b) {
      return b.dateAndTime.compareTo(a.dateAndTime);
    });
    List<Widget> pastAppoinmentWidgetList = [];

    for (Appoinment tempAppoinment in pastAppoinment) {
      String date, time;
      dateTime = DateTime.parse(tempAppoinment.dateAndTime);

      date = dateTime.day.toString() +
          '/' +
          dateTime.month.toString() +
          '/' +
          dateTime.year.toString();
      if (dateTime.minute == 0) {
        time =
            dateTime.hour.toString() + ':' + dateTime.minute.toString() + '0';
      } else if (dateTime.minute < 10)
        time = dateTime.hour.toString() + ':0' + dateTime.minute.toString();
      else
        time = dateTime.hour.toString() + ':' + dateTime.minute.toString();
      pastAppoinmentWidgetList.add(Builder(
        builder: (context) => InkWell(
            onLongPress: () async {
              //_showSnackBar(context, 'Appoinment Deleted');
              _delete(context, tempAppoinment);
            },
            highlightColor: Colors.white70,
            child: OtherAppoinment(
              name: tempAppoinment.name,
              type: tempAppoinment.address,
              time: time,
              date: date,
            )),
      ));
    }

    return pastAppoinmentWidgetList;
  }

  List<Widget> getUpcomingAppoinmentWidget(BuildContext context) {
    upcomingAppoinment.sort((a, b) {
      return a.dateAndTime.compareTo(b.dateAndTime);
    });
    List<Widget> upcomingAppoinmentWidgetList = [];

    for (Appoinment tempAppoinment in upcomingAppoinment) {
      String date, time;
      dateTime = DateTime.parse(tempAppoinment.dateAndTime);
      date = dateTime.day.toString() +
          '/' +
          dateTime.month.toString() +
          '/' +
          dateTime.year.toString();
      if (dateTime.minute == 0) {
        time =
            dateTime.hour.toString() + ':' + dateTime.minute.toString() + '0';
      } else if (dateTime.minute < 10)
        time = dateTime.hour.toString() + ':0' + dateTime.minute.toString();
      else
        time = dateTime.hour.toString() + ':' + dateTime.minute.toString();
      upcomingAppoinmentWidgetList.add(Builder(
        builder: (context) => InkWell(
            onTap: () {
              navigateToDetail(tempAppoinment, 'Edit');
            },
            onLongPress: () async {
              _showSnackBar(context, 'Appoinment Deleted');
              _delete(context, tempAppoinment);
            },
            child: OtherAppoinment(
              name: tempAppoinment.name,
              type: tempAppoinment.address,
              time: time,
              date: date,
            )),
      ));
    }

    return upcomingAppoinmentWidgetList;
  }

  List<Widget> getTodayAppoinmentWidget(BuildContext context) {
    todayAppoinment.sort((a, b) {
      return b.dateAndTime.compareTo(a.dateAndTime);
    });

    List<Widget> todayAppoinmentWidgetList = [];
    Color color = Colors.green;
    for (Appoinment tempAppoinment in todayAppoinment) {
      dateTime = DateTime.parse(tempAppoinment.dateAndTime);

      String time;
      if (dateTime.minute == 0) {
        time =
            dateTime.hour.toString() + ':' + dateTime.minute.toString() + '0';
      } else if (dateTime.minute < 10)
        time = dateTime.hour.toString() + ':0' + dateTime.minute.toString();
      else
        time = dateTime.hour.toString() + ':' + dateTime.minute.toString();
      todayAppoinmentWidgetList.add(
        Card(
          margin: EdgeInsets.all(8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {
                print('tap');
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AppoinmentDecision(tempAppoinment);
                }));
              },
              onLongPress: () async {
                _showSnackBar(context, 'Appoinment Done');
                setState(() {
                  tempAppoinment.done = true;
                  color = Colors.yellow;
                });
                await databaseHelper.updateAppoinment(tempAppoinment);
              },
              leading: CircleAvatar(
                backgroundColor: color,
                radius: 38,
                child: Icon(
                  FontAwesomeIcons.userMd,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              title: Text(
                tempAppoinment.name,
                style: kTextStyle.copyWith(
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              trailing: Text(time),
              subtitle:
                  Text(tempAppoinment.address + ' at ' + tempAppoinment.place),
            ),
          ),
        ),
      );
    }

    return todayAppoinmentWidgetList;
  }

  @override
  Widget build(BuildContext context) {
    if (appoinmentList == null) {
      appoinmentList = List<Appoinment>();
      updateListView();
    }

    getTodayAppoinment();
    getUpcomingAppoinment();
    getPastAppoinment();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          return Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
        },
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 35,
            ),
            Text(
              month + '  ' + year,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, color: Colors.green),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: textWidgets),
            SizedBox(
              height: 20,
            ),
            todayAppoinment.length == 0
                ? Center(
                    child: Text(
                      'No Appointments today',
                    ),
                  )
                : Column(
                    children: getTodayAppoinmentWidget(context),
                  ),
            SizedBox(
              height: 17,
            ),
            HeadingText(
              title: 'Upcoming',
              color: Colors.teal,
            ),
            SizedBox(
              height: 8,
            ),
            upcomingAppoinment.isNotEmpty
                ? Column(
                    children: getUpcomingAppoinmentWidget(context),
                  )
                : Center(child: Text('No Upcoming Appointments')),
            SizedBox(
              height: 15,
            ),
            HeadingText(
              title: 'Past Appointments',
              color: Colors.deepOrangeAccent,
            ),
            SizedBox(
              height: 10,
            ),
            pastAppoinment.isNotEmpty
                ? Column(
                    children: getPastAppoinmentWidget(context),
                  )
                : Container(
                    margin: EdgeInsets.only(bottom: 35),
                    child: Center(
                      child: Text('No past Appointments'),
                    ),
                  ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        onPressed: () {
          navigateToDetail(appoinment, 'Add');
        },
      ),
      appBar: ElderlyAppBar(),
    );
  }

  void _delete(BuildContext context, Appoinment appoinment) async {
    int result = await databaseHelper.deleteAppoinment(appoinment.id);
    if (result != 0) {
      updateListView();
    }
  }

  void navigateToDetail(Appoinment appoinment, String name) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AppoinmentDetail(appoinment, name);
      //return ReminderDetail();
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Appoinment>> appoinmentListFuture =
          databaseHelper.getAppoinmentList();
      appoinmentListFuture.then((appoinmentList) {
        setState(() {
          this.appoinmentList = appoinmentList;
          this.count = appoinmentList.length;
        });
      });
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 5),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class HeadingText extends StatelessWidget {
  final String title;
  final color;
  HeadingText({this.color, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 20),
      child: Text(
        '$title :',
        style:
            TextStyle(color: color, fontSize: 23, fontWeight: FontWeight.w800),
      ),
    );
  }
}

class OtherAppoinment extends StatelessWidget {
  final String time, date, type, name;
  OtherAppoinment({this.name, this.date, this.type, this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 8),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
          //color: Colors.grey,
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(25), right: Radius.circular(25))),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 25,
          ),
          Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Dr.' + name,
                    style: TextStyle(
                        fontSize: 19,
                        color: Colors.brown,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    type,
                    style: TextStyle(color: Colors.brown, fontSize: 16),
                  ),
                  SizedBox(height: 5)
                ],
              )),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    date,
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    time,
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w600),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class TodayAppoinment extends StatelessWidget {
  TodayAppoinment({
    this.type,
    this.name,
    this.place,
    this.time,
    @required this.kTextStyle,
  });

  final TextStyle kTextStyle;
  final String time, place, name, type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
      padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
      decoration: BoxDecoration(
        color: Color(0xfff5f5f5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 38,
                  child: Icon(
                    FontAwesomeIcons.userMd,
                    size: 43,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8),
                  child: Text(
                    time,
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Dr.' + name,
              style: kTextStyle.copyWith(
                  letterSpacing: 1, fontWeight: FontWeight.bold, fontSize: 19),
            ),
          )
        ],
      ),
    );
  }
}
