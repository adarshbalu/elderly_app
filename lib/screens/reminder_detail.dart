import 'dart:io';
import 'package:elderly_app/others/database_helper.dart';
import 'package:elderly_app/screens/medicine_reminder.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'profile_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:elderly_app/models/reminder.dart';

class ReminderDetail extends StatefulWidget {
  static const String id = 'Medicine_detail_screen';

  final String pageTitle;
  final Reminder reminder;

  ReminderDetail(this.reminder, [this.pageTitle]);

  @override
  State<StatefulWidget> createState() {
    return _ReminderDetailState(this.reminder, this.pageTitle);
  }
}

class _ReminderDetailState extends State<ReminderDetail> {
  DatabaseHelper helper = DatabaseHelper();
  Reminder reminder;
  String pageTitle;

  _ReminderDetailState(this.reminder, this.pageTitle);

  TimeOfDay selectedTime1 = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay selectedTime2 = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay selectedTime3 = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay timeNow = TimeOfDay.now();

  int times = 2;

  String medicineName = '', tempName = '', medicineType = '';

  File pickedImage;
  bool isImageLoaded = false;

  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    typeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    medicineName = nameController.text = reminder.name;
    medicineType = typeController.text = reminder.type;
    times = reminder.times;
    String tempTime1 = reminder.time1;
    var tempTime2 = reminder.time2;
    var tempTime3 = reminder.time3;

    super.initState();
  }

  final nameController = TextEditingController();
  final typeController = TextEditingController();

  Future readText() async {
    setState(() {
      nameController.value = TextEditingValue(text: '');
      nameController.text = '';
      medicineName = '';
      tempName = null;
      isImageLoaded = false;
    });

    FirebaseVisionImage firebaseVisionImage =
        FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(firebaseVisionImage);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          tempName = word.text;
        }
      }
    }
    setState(() {
      if (medicineName == '') {
        medicineName = tempName;
        nameController.text = medicineName;
      } else {
        medicineName = '';
        nameController.clear();
        isImageLoaded = false;
        tempName = '';
      }
    });
  }

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
      body: WillPopScope(
        onWillPop: () {
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
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => MedicineReminder()),
                            (Route<dynamic> route) => false);
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
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    '$pageTitle' ?? 'Reminder ',
                    style: TextStyle(
                      fontSize: 32,
                      color: Color(0xffE3952D),
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: ReminderFormItem(
                      helperText: 'Name of Reminder',
                      hintText: 'Enter Medicine Name',
                      controller: nameController,
                      onChanged: (value) {
                        setState(() {
                          medicineName = value.toString();
                        });
                      },
                      isNumber: false,
                      icon: FontAwesomeIcons.capsules,
                    ),
                  ),
                  Expanded(
                    child: Tooltip(
                      message: 'Detect Name from Image',
                      child: GestureDetector(
                        child: Icon(
                          Icons.photo_camera,
                          color:
                              isImageLoaded ? Colors.green : Colors.amberAccent,
                          size: 43,
                        ),
                        onTap: () async {
                          await pickImage();
                          nameController.clear();
                          medicineName = '';
                          await readText();
                        },
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ReminderFormItem(
                helperText: 'Give the type for reference',
                hintText: 'Enter type of medicine',
                controller: typeController,
                onChanged: (value) {
                  setState(() {
                    medicineType = value;
                  });
                },
                isNumber: false,
                icon: FontAwesomeIcons.syringe,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 10),
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
                height: 13,
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
                            borderRadius:
                                BorderRadiusDirectional.circular(100)),
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
                height: 10,
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    print('tap');
                    setState(() {
                      reminder.times = times;
                      reminder.name = medicineName;
                      reminder.type = medicineType;
                      if (times == 1) reminder.time1 = selectedTime1.toString();
                      if (times >= 2)
                        reminder.time2 = selectedTime2.toString();
                      else
                        reminder.time2 = '0';
                      if (times >= 3)
                        reminder.time3 = selectedTime3.toString();
                      else
                        reminder.time3 = '0';
                    });
                    _save();
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      '$pageTitle',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
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
    int result;
    if (reminder.id != null) {
      // Case 1: Update operation
      result = await helper.updateReminder(reminder);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertReminder(reminder);
    }

    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Reminder Saved Successfully');
//      await Navigator.push(context, MaterialPageRoute(builder: (context) {
//        return MedicineReminder();
//      }));

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MedicineReminder()),
          (Route<dynamic> route) => false);
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Reminder');
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

class ReminderFormItem extends StatelessWidget {
  final String hintText;
  final String helperText;
  Function onChanged;
  final bool isNumber;
  IconData icon;
  final controller;

  ReminderFormItem(
      {this.hintText,
      this.helperText,
      this.onChanged,
      this.icon,
      this.isNumber: false,
      this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextField(
        maxLines: 1,
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
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}
