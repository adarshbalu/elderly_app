import 'dart:math';
import 'package:elderly_app/models/appoinment.dart';
import 'package:elderly_app/others/database_helper.dart';
import 'package:elderly_app/others/notification_service.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class AppoinmentDetail extends StatefulWidget {
  static const String id = 'Appoinment_Detail_Screen';
  final String pageTitle;
  final Appoinment appoinment;

  AppoinmentDetail(this.appoinment, [this.pageTitle]);

  @override
  State<StatefulWidget> createState() {
    return _AppoinmentDetailState(this.appoinment, this.pageTitle);
  }
}

class _AppoinmentDetailState extends State<AppoinmentDetail> {
  DatabaseHelper helper = DatabaseHelper();
  Appoinment appoinment;
  String pageTitle;
  var rng = Random();
  _AppoinmentDetailState(this.appoinment, this.pageTitle);
  int notificationID;
  String doctorName = '', place = '', address = '';
  DateTime date, dateCheck, tempDate = DateTime(0000, 00, 00, 00, 00);
  TimeOfDay timeSelected = TimeOfDay(minute: 0, hour: 0);
  NotificationService notificationService;
  TextEditingController nameController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController addressController = TextEditingController(text: '');
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  final f = DateFormat('yyyy-MM-dd hh:mm');
  DateTime newDate;
  @override
  void dispose() {
    nameController.dispose();
    placeController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    doctorName = nameController.text = appoinment.name;
    place = placeController.text = appoinment.place;
    address = addressController.text = appoinment.address;
    date = dateCheck = DateTime.parse(appoinment.dateAndTime);
    tempDate = DateTime(date.year, date.month, date.day);
    timeSelected = TimeOfDay(hour: date.hour, minute: date.minute);
    notificationID = appoinment.notificationId;
    notificationService = NotificationService();
    notificationService.initialize();
    super.initState();
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2025));
    if (picked != null) setState(() => tempDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: ElderlyAppBar(),
      body: WillPopScope(
        onWillPop: () async {
          if (appoinment !=
              Appoinment(doctorName, place, date.toString(), address,
                  notificationID, false)) {
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RichAlertDialog(
                    alertTitle: richTitle("Reminder Not Saved"),
                    alertSubtitle: richSubtitle('Changes will be discarded '),
                    alertType: RichAlertType.WARNING,
                    actions: <Widget>[
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                });
          } else
            return true;
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '$pageTitle Appoinment',
                    style: TextStyle(color: Colors.green, fontSize: 28),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              AppoinmentFormItem(
                helperText: 'Full name',
                hintText: 'Enter name of the Doctor',
                controller: nameController,
                onChanged: (value) {
                  setState(() {
                    doctorName = value;
                  });
                },
                isNumber: false,
                icon: FontAwesomeIcons.userMd,
              ),
              SizedBox(
                height: 8,
              ),
              AppoinmentFormItem(
                helperText: 'Hospital , Home',
                hintText: 'Enter place of Visit',
                controller: placeController,
                onChanged: (value) {
                  setState(() {
                    place = value;
                  });
                },
                isNumber: false,
                icon: FontAwesomeIcons.clinicMedical,
              ),
              SizedBox(
                height: 8,
              ),
              AppoinmentFormItem(
                helperText: 'Any Specialization',
                hintText: 'Enter type ',
                controller: addressController,
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
                isNumber: false,
                icon: FontAwesomeIcons.briefcaseMedical,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Date',
                          style: TextStyle(color: Colors.teal),
                        ),
                        InkWell(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.event_note,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () async {
                            await _selectDate();
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Time',
                          style: TextStyle(color: Colors.teal),
                        ),
                        InkWell(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.alarm_add,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () async {
                            showMaterialTimePicker(
                              context: context,
                              selectedTime: timeSelected,
                              onChanged: (value) => setState(() {
                                timeSelected = value;
                              }),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 16, 18, 1),
                child: RaisedButton(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hoverElevation: 5,
                  highlightColor: Colors.green.withAlpha(10),
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                  onPressed: () async {
                    if (!(timeSelected.minute == 0 && timeSelected.hour == 0)) {
                      if (!(tempDate.year == 0 &&
                          tempDate.month == 0 &&
                          tempDate.day == 0)) {
                        setState(() {
                          date = DateTime(
                              tempDate.year,
                              tempDate.month,
                              tempDate.day,
                              timeSelected.hour,
                              timeSelected.minute);
                        });

                        _save();
                        Navigator.pop(context);
                      } else {}
                    }
                  },
                  child: Text(
                    '$pageTitle Appoinment',
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Save data to database
  void _save() async {
    appoinment.dateAndTime = f.format(date);
    appoinment.name = doctorName;
    appoinment.address = address;
    appoinment.place = place;

    int result;
    if (appoinment.id != null) {
      // Case 1: Update operation
      result = await helper.updateAppoinment(appoinment);
    } else {
      // Case 2: Insert Operation
      appoinment.notificationId = rng.nextInt(9999);
      result = await helper.insertAppoinment(appoinment);
      if (date.isAfter(DateTime.now()))
        notificationService.scheduleAppoinmentNotification(
            id: appoinment.notificationId,
            title: appoinment.name,
            body: appoinment.place + ' ' + appoinment.address,
            dateTime: date);
    }
    if (date != dateCheck) {
      notificationService.deleteNotification(appoinment.notificationId);
      if (date.isAfter(DateTime.now()))
        notificationService.scheduleAppoinmentNotification(
            id: appoinment.notificationId,
            title: appoinment.name,
            body: appoinment.place + ' ' + appoinment.address,
            dateTime: date);
    }
    if (result != 0) {
      // Success

      Navigator.pop(context);
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Appoinment');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}

class AppoinmentFormItem extends StatelessWidget {
  final String hintText;
  final String helperText;
  final Function onChanged;
  final bool isNumber;
  final IconData icon;
  final controller;

  AppoinmentFormItem(
      {this.hintText,
      this.helperText,
      this.onChanged,
      this.icon,
      this.isNumber: false,
      this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 7, 10, 7),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: Color(0xffaf5676), style: BorderStyle.solid)),
          prefixIcon: Icon(icon, color: Colors.green),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(color: Colors.indigo, style: BorderStyle.solid)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: Color(0xffaf5676), style: BorderStyle.solid)),
        ),
        onChanged: (String value) {
          onChanged(value);
        },
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}
