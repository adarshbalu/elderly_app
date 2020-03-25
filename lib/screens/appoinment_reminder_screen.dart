import 'package:elderly_app/models/appoinment.dart';
import 'package:elderly_app/others/database_helper.dart';
import 'package:elderly_app/screens/appoinment_detail_screen.dart';
import 'package:elderly_app/screens/profile_screen.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/cupertino.dart';
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
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Appoinment> appoinmentList;
  Appoinment appoinment =
      Appoinment('', '', DateTime(0000, 00, 00, 00, 00, 00).toString(), '');
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

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    if (appoinmentList == null) {
      appoinmentList = List<Appoinment>();
      updateListView();
    }
    return Scaffold(
      body: ListView(
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
//          Text(
//            'No appoinment today',
//            textAlign: TextAlign.center,
//          ),
          Container(
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
                        radius: 47,
                        child: Icon(
                          FontAwesomeIcons.userMd,
                          size: 65,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8),
                        child: Text('5:00 pm'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(' Appoinment Place'),
                      SizedBox(
                        height: 25,
                      ),
                      Text('Doctor Name'),
                      SizedBox(
                        height: 25,
                      ),
                      Text('Date'),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 20),
            child: Text(
              'Upcoming :',
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 26,
                  fontWeight: FontWeight.w800),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              children: <Widget>[
                Column(),
                Column(),
              ],
            ),
          )
        ],
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
    );
  }

  ListView getAppoinmentListView() {
    bool first = true;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        tempDay = DateTime.parse(this.appoinmentList[position].dateAndTime).day;
        tempMonth =
            DateTime.parse(this.appoinmentList[position].dateAndTime).month;
        tempYear =
            DateTime.parse(this.appoinmentList[position].dateAndTime).year;
        tempHour =
            DateTime.parse(this.appoinmentList[position].dateAndTime).hour;
        tempMinute =
            DateTime.parse(this.appoinmentList[position].dateAndTime).minute;

        if (first) {
          first = false;
          return Column(children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text(
              'Appoinments',
              style: TextStyle(fontSize: 25, color: Colors.green),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              margin: EdgeInsets.all(18),
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                leading: Icon(Icons.local_hospital),
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        this.appoinmentList[position].name ?? ' ',
                        style:
                            TextStyle(color: Colors.blue, letterSpacing: 1.01),
                      ),
                    ),
                    Expanded(
                        child: Text(
                            'To : ' + this.appoinmentList[position].place ??
                                ' '))
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text(tempDay.toString() +
                          '/' +
                          tempMonth.toString() +
                          '/' +
                          tempYear.toString() +
                          '  at ' +
                          tempHour.toString() +
                          ':' +
                          tempMinute.toString() ??
                      ' '),
                ),
                trailing: GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    _delete(context, appoinmentList[position]);
                  },
                ),
                onTap: () {
                  debugPrint("ListTile Tapped");
                  navigateToDetail(this.appoinmentList[position], 'Edit ');
                },
              ),
            )
          ]);
        } else
          return Card(
            margin: EdgeInsets.all(18),
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: Icon(Icons.local_hospital),
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      this.appoinmentList[position].name ?? ' ',
                      style: TextStyle(color: Colors.blue, letterSpacing: 1.01),
                    ),
                  ),
                  Expanded(
                      child: Text(
                          'To : ' + this.appoinmentList[position].place ?? ' '))
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Text(tempDay.toString() +
                        '/' +
                        tempMonth.toString() +
                        '/' +
                        tempYear.toString() +
                        '  at ' +
                        tempHour.toString() +
                        ':' +
                        tempMinute.toString() ??
                    ' '),
              ),
              trailing: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onTap: () {
                  _delete(context, appoinmentList[position]);
                },
              ),
              onTap: () {
                debugPrint("ListTile Tapped");
                navigateToDetail(this.appoinmentList[position], 'Edit ');
              },
            ),
          );
      },
    );
  }

  void _delete(BuildContext context, Appoinment appoinment) async {
    int result = await databaseHelper.deleteAppoinment(appoinment.id);
    if (result != 0) {
      _showSnackBar(context, 'Appoinment Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
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
}
