import 'package:elderly_app/models/reminder.dart';
import 'package:elderly_app/others/database_helper.dart';
import 'package:elderly_app/widgets/app_default.dart';
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
  List<Reminder> reminderList;
  int count = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    updateListView();
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

    return Scaffold(
      drawer: AppDrawer(),
      floatingActionButton: count != 0
          ? FloatingActionButton(
              onPressed: () {
                print(_reminder.name);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ReminderDetail(_reminder, 'Add Reminder');
                  //return ReminderDetail();
                }));
              },
              backgroundColor: Color(0xffE3952D),
              child: Icon(Icons.add),
            )
          : SizedBox(),
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

  ListView getReminderListView() {
    bool first = true;
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        if (first) {
          first = false;
          return Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Text(
                'Reminders',
                style: TextStyle(fontSize: 25, color: Colors.amber),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                margin: EdgeInsets.fromLTRB(8.0, 25, 8, 5),
                color: Colors.white70,
                elevation: 2.0,
                child: ListTile(
                  leading: Icon(
                    Icons.alarm_on,
                    color: Colors.green,
                  ),
                  title: Text(
                    this.reminderList[position].name.toUpperCase() ?? ' ',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(this.reminderList[position].type ?? ' ')),
                      Expanded(
                        child: Text(
                            this.reminderList[position].times.toString() +
                                    ' per Day' ??
                                ''),
                      )
                    ],
                  ),
                  trailing: GestureDetector(
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onTap: () {
                      _delete(context, reminderList[position]);
                    },
                  ),
                  onTap: () {
                    debugPrint("ListTile Tapped");
                    navigateToDetail(
                        this.reminderList[position], 'Edit Reminder');
                  },
                ),
              )
            ],
          );
        } else
          return Card(
            margin: EdgeInsets.fromLTRB(8.0, 25, 8, 5),
            color: Colors.white70,
            elevation: 2.0,
            child: ListTile(
              leading: Icon(
                Icons.alarm_on,
                color: Colors.green,
              ),
              title: Text(
                this.reminderList[position].name.toUpperCase() ?? ' ',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
              subtitle: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(this.reminderList[position].type ?? ' ')),
                  Expanded(
                    child: Text(this.reminderList[position].times.toString() +
                            ' per Day' ??
                        ''),
                  )
                ],
              ),
              trailing: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onTap: () {
                  _delete(context, reminderList[position]);
                },
              ),
              onTap: () {
                debugPrint("ListTile Tapped");
                navigateToDetail(this.reminderList[position], 'Edit Reminder');
              },
            ),
          );
      },
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
