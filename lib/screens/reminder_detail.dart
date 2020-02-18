import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';

class ReminderDetail extends StatefulWidget {
  static const String id = 'Medicine_detail_screen';
  @override
  _ReminderDetailState createState() => _ReminderDetailState();
}

class _ReminderDetailState extends State<ReminderDetail> {
//  DateTime selectedDate = DateTime.now();
//  Future<Null> _selectDate(BuildContext context) async {
//    final DateTime picked = await showDatePicker(
//        context: context,
//        initialDate: selectedDate,
//        firstDate: DateTime(2015, 8),
//        lastDate: DateTime(2101));
//    if (picked != null && picked != selectedDate)
//      setState(() {
//        selectedDate = picked;
//      });
//  }
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
      });
  }

  int times = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Text(
                'Edit Details',
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xffE3952D),
                ),
              ),
            ),
          ),
          ReminderFormItem(
            helperText: 'This name will be dispalyed on Reminder',
            hintText: 'Enter Medicine Name',
            onChanged: () {
              print('Name Saved');
            },
            isNumber: false,
            icon: FontAwesomeIcons.capsules,
          ),
          ReminderFormItem(
            helperText: 'Consumption of Medicine on a single day',
            hintText: 'Enter times a day ',
            onChanged: (value) {
              times = value;
              print(times);
            },
            icon: FontAwesomeIcons.diagnoses,
            isNumber: true,
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            onPressed: () => _selectTime(context),
            child: Text('Select date'),
          ),
        ],
      ),
    );
  }
}

class ReminderFormItem extends StatelessWidget {
  final String hintText;
  final String helperText;
  Function onChanged;
  final bool isNumber;
  IconData icon;

  ReminderFormItem({
    this.hintText,
    this.helperText,
    this.onChanged,
    this.icon,
    this.isNumber: false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color(0xffaf5676), style: BorderStyle.solid)),
          helperText: helperText,
          icon: Icon(icon, color: Colors.blueAccent),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: Colors.indigo, style: BorderStyle.solid)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color(0xffaf5676), style: BorderStyle.solid)),
        ),
        onChanged: (String value) {
          onChanged(value);
        },
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}
