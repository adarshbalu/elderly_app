import 'package:elderly_app/screens/home_screen.dart';
import 'package:elderly_app/screens/profile_screen.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AppoinmentDetail extends StatefulWidget {
  static const String id = 'Appoinment_Detail_Screen';
  @override
  _AppoinmentDetailState createState() => _AppoinmentDetailState();
}

class _AppoinmentDetailState extends State<AppoinmentDetail> {
  String doctorName, place, address;
  DateTime date, tempDate = DateTime(0000, 00, 00, 00, 00);
  TimeOfDay timeSelected = TimeOfDay(minute: 0, hour: 0);

  TextEditingController nameController;
  TextEditingController placeController;
  TextEditingController addressController;
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");

  @override
  void dispose() {
    nameController.dispose();
    placeController.dispose();
    addressController.dispose();
    super.dispose();
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
          SizedBox(
            height: 15,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Appoinment Reminder',
                style: TextStyle(color: Colors.green, fontSize: 28),
              ),
            ),
          ),
          SizedBox(
            height: 20,
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
          AppoinmentFormItem(
            helperText: 'Brief address',
            hintText: 'Enter address ',
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
            height: 20,
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
                        print(tempDate.toString());
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
                            print(timeSelected.toString());
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
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: MaterialButton(
              elevation: 10,
              hoverElevation: 5,
              highlightColor: Colors.green.withAlpha(10),
              color: Colors.green,
              padding: EdgeInsets.all(20),
              onPressed: () {
                if (!(timeSelected.minute == 0 && timeSelected.hour == 0)) {
                  if (!(tempDate.year == 0 &&
                      tempDate.month == 0 &&
                      tempDate.day == 0)) {
                    setState(() {
                      date = DateTime(tempDate.year, tempDate.month,
                          tempDate.day, timeSelected.hour, timeSelected.minute);
                    });

                    print(date.toString());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeScreen(true);
                    }));
                  } else {
                    print('fail');
                  }
                }
              },
              child: Text(
                'Add Appoinment',
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AppoinmentFormItem extends StatelessWidget {
  final String hintText;
  final String helperText;
  Function onChanged;
  final bool isNumber;
  IconData icon;
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
      margin: EdgeInsets.fromLTRB(10, 10, 10, 8),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color(0xffaf5676), style: BorderStyle.solid)),
          helperText: helperText,
          icon: Icon(icon, color: Colors.green),
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
