import 'dart:io';
import 'dart:math';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class ReminderDetail extends StatefulWidget {
  static const String id = 'Medicine_detail_screen';
  @override
  _ReminderDetailState createState() => _ReminderDetailState();
}

class _ReminderDetailState extends State<ReminderDetail> {
  TimeOfDay selectedTime1 = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();
  TimeOfDay selectedTime3 = TimeOfDay.now();
  TimeOfDay timeNow = TimeOfDay.now();

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  int times = 2;
  String remindOn = 'Daily';

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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
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
              helperText: 'Give the type for reference',
              hintText: 'Enter type of medicine',
              onChanged: () {
                print('Name Saved');
              },
              isNumber: false,
              icon: FontAwesomeIcons.syringe,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 0),
              child: Text(
                'Times a day : ',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Once : '),
                  Radio(
                    onChanged: (value) {
                      setState(() {
                        times = value;
                      });
                    },
                    activeColor: Color(0xffE3952D),
                    value: 1,
                    groupValue: times,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Twice : '),
                  Radio(
                    onChanged: (value) {
                      setState(() {
                        times = value;
                      });
                    },
                    activeColor: Color(0xffE3952D),
                    value: 2,
                    groupValue: times,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Thrice : '),
                  Radio(
                    activeColor: Color(0xffE3952D),
                    onChanged: (value) {
                      setState(() {
                        times = value;
                      });
                    },
                    value: 3,
                    groupValue: times,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                times == 1
                    ? SizedBox(
                        width: 80,
                      )
                    : SizedBox(),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showMaterialTimePicker(
                        context: context,
                        selectedTime: selectedTime1,
                        onChanged: (value) =>
                            setState(() => selectedTime1 = value),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Icon(
                        Icons.access_alarm,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Color(0xffff8f00),
                          borderRadius: BorderRadiusDirectional.circular(100)),
                    ),
                  ),
                ),
                times >= 2
                    ? Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showMaterialTimePicker(
                              context: context,
                              selectedTime: selectedTime2,
                              onChanged: (value) =>
                                  setState(() => selectedTime2 = value),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Icon(
                              Icons.access_alarm,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Color(0xffff8f00),
                                borderRadius:
                                    BorderRadiusDirectional.circular(100)),
                          ),
                        ),
                      )
                    : SizedBox(),
                times == 3
                    ? Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showMaterialTimePicker(
                              context: context,
                              selectedTime: selectedTime3,
                              onChanged: (value) =>
                                  setState(() => selectedTime3 = value),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Icon(
                              Icons.access_alarm,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Color(0xffff8f00),
                                borderRadius:
                                    BorderRadiusDirectional.circular(100)),
                          ),
                        ),
                      )
                    : SizedBox(),
                times == 1
                    ? SizedBox(
                        width: 80,
                      )
                    : SizedBox(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Remind on :',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: DropdownButton(
                iconEnabledColor: Color(0xffff8f00),
                style: TextStyle(fontSize: 20, color: Colors.black),
                value: remindOn,
                items: [
                  DropdownMenuItem(
                    value: 'Daily',
                    child: Text('Daily'),
                  ),
                  DropdownMenuItem(
                    value: 'Weekly',
                    child: Text('Weekly'),
                  ),
                  DropdownMenuItem(
                    value: 'Monthy',
                    child: Text('Monthly'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    remindOn = value;
                  });
                },
                focusColor: Color(0xffff8f00),
              ),
            ),
            Text(
              _image == null ? 'Optional : Add an Image' : 'Image Loaded',
              textAlign: TextAlign.center,
            ),
            _image == null
                ? InkWell(
                    onTap: () async {
                      Map<PermissionGroup, PermissionStatus> permissions =
                          await PermissionHandler().requestPermissions(
                              [PermissionGroup.mediaLibrary]);
                      getImage();
                    },
                    child: Container(
                      child: Icon(
                        Icons.image,
                        size: 100,
                        color: Color(0xffE3952D),
                      ),
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 8),
              child: Text(
                'Reminder set on : ',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Reminder 1 : ' +
                        selectedTime1.hour.toString() +
                        ' : ' +
                        selectedTime1.minute.toString(),
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  times >= 2
                      ? Text(
                          'Reminder 2 : ' +
                              selectedTime2.hour.toString() +
                              ' : ' +
                              selectedTime2.minute.toString(),
                          style: TextStyle(fontSize: 15),
                        )
                      : SizedBox(),
                  SizedBox(
                    width: 10,
                  ),
                  times == 3
                      ? Text(
                          'Reminder 3 : ' +
                              selectedTime3.hour.toString() +
                              ' : ' +
                              selectedTime3.minute.toString(),
                          style: TextStyle(fontSize: 15),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  print('tap');
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Create Reminder',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
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
          icon: Icon(icon, color: Color(0xffE3952D)),
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