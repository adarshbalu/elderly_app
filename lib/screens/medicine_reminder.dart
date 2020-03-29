import 'package:elderly_app/models/reminder.dart';
import 'package:elderly_app/others/database_helper.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'package:elderly_app/others/functions.dart';
import 'reminder_detail.dart';

class MedicineReminder extends StatefulWidget {
  static const String id = 'Medicine_home_screen';
  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  Reminder _reminder = Reminder('', '', '', '', '', 2);

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Reminder> reminderList = [];
  int count = 0;

  DateTime dateTime = DateTime.now();
  String today = '';
  Map<int, String> weekDays = {};
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
              fontSize: 21, fontWeight: FontWeight.bold, color: Colors.black87),
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
    double screenWidth = getDeviceWidth(context);
    double screenHeight = getDeviceHeight(context);
    if (reminderList == null) {
      reminderList = List<Reminder>();
      updateListView();
    }
    updateListView();
    double width = MediaQuery.of(context).size.width;
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
      body: count != 0
          ? WillPopScope(
              onWillPop: () {
                return Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomeScreen(true)),
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

//
  Widget getReminderListView() {
    double width = getDeviceWidth(context);
    bool first = true;
    return Column(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(color: Color(0xff0C9731)),
            child: Column(children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                'Medicine Reminder',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 29),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.only(top: 0),
                padding: EdgeInsets.only(top: 15, bottom: 6),
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: getWeekDayWidgets(),
                ),
              ),
            ])),
        SizedBox(
          height: 0,
        ),
        Flexible(
          child: Stack(
            children: <Widget>[
              Container(
                margin:
                    EdgeInsets.only(top: 35, left: 10, right: 10, bottom: 0),
                padding: EdgeInsets.only(top: 7, bottom: 15),
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
                    padding: EdgeInsets.all(8),
                    itemCount: count,
                    itemBuilder: (BuildContext context, int position) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(38.0, 26, 38, 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
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
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: width / 3,
                left: width / 3,
                child: CircleAvatar(
                  radius: 35.8,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.filter_none,
                  ),
                ),
              ),
              Positioned(
                right: width / 3,
                left: width / 3,
                top: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ReminderDetail(_reminder, 'Add Reminder');
                      //return ReminderDetail();
                    }));
                  },
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
            ],
          ),
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
      _showSnackBar(context, 'Reminder Deleted Successfully');
      updateListView();
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
}
