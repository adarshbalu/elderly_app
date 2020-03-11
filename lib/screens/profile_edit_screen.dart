import 'package:flutter/material.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:elderly_app/others/functions.dart';

class ProfileEdit extends StatefulWidget {
  static const String id = 'profile_edit_screen';
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final userNameController = TextEditingController();
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final bloodGroupController = TextEditingController();
  String userName, bloodPressure, bloodSugar, bloodGroup, allergies;
  final bloodPressureController = TextEditingController();
  int age;
  final allergiesController = TextEditingController();
  final bloodSugarController = TextEditingController();
  double weight, height;
  var gender;
  @override
  void dispose() {
    allergiesController.dispose();
    ageController.dispose();
    bloodGroupController.dispose();
    bloodPressureController.dispose();
    bloodSugarController.dispose();
    userNameController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = getDeviceWidth(context);
    double screenHeight = getDeviceHeight(context);

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
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue.shade50,
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
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Center(
                child: Text(
                  'Edit Details',
                  style: TextStyle(color: Colors.green, fontSize: 40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('Name : ')),
                  Expanded(
                    flex: 6,
                    child: FormItem(
                      helperText: 'Name of the user',
                      hintText: 'Enter type of User Name',
                      controller: userNameController,
                      onChanged: () {
                        print('Name Saved');
                        setState(() {
                          userName = userNameController.text;
                        });
                      },
                      isNumber: false,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 0),
              child: Text(
                'Gender : ',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Male : '),
                  Radio(
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                    activeColor: Color(0xffE3952D),
                    value: 1,
                    groupValue: gender,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Female : '),
                  Radio(
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                    activeColor: Color(0xffE3952D),
                    value: 2,
                    groupValue: gender,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 5, 0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('Age : ')),
                  Expanded(
                    flex: 6,
                    child: FormItem(
                      helperText: 'Age',
                      hintText: 'Enter Age ',
                      controller: weightController,
                      onChanged: () {
                        print('Name Saved');
                        setState(() {
                          age = ageController.text as int;
                        });
                      },
                      isNumber: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('Weight:')),
                  Expanded(
                    flex: 6,
                    child: FormItem(
                      helperText: 'Weight ',
                      hintText: 'Enter weight',
                      controller: weightController,
                      onChanged: () {
                        print('Name Saved');
                        setState(() {
                          weight = weightController.text as double;
                        });
                      },
                      isNumber: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('Weight:')),
                  Expanded(
                    flex: 6,
                    child: FormItem(
                      helperText: 'Weight ',
                      hintText: 'Enter weight',
                      controller: weightController,
                      onChanged: () {
                        print('Name Saved');
                        setState(() {
                          height = heightController.text as double;
                        });
                      },
                      isNumber: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('Blood Group :')),
                  Expanded(
                    flex: 6,
                    child: FormItem(
                      helperText: 'Weight ',
                      hintText: 'Enter Blood Group',
                      controller: bloodGroupController,
                      onChanged: () {
                        print('Name Saved');
                        setState(() {
                          bloodGroup = bloodGroupController.text;
                        });
                      },
                      isNumber: false,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    'Blood Pressure :',
                    style: TextStyle(fontSize: 16),
                  )),
                  Expanded(
                    flex: 6,
                    child: FormItem(
                      hintText: 'Enter Blood Pressure',
                      controller: bloodPressureController,
                      onChanged: () {
                        print('Name Saved');
                        setState(() {
                          bloodPressure = bloodPressureController.text;
                        });
                      },
                      isNumber: false,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    'Blood Sugar :',
                    style: TextStyle(fontSize: 15),
                  )),
                  Expanded(
                    flex: 6,
                    child: FormItem(
                      helperText: 'Weight ',
                      hintText: 'Enter Blood Sugar',
                      controller: bloodSugarController,
                      onChanged: () {
                        print('Name Saved');
                        setState(() {
                          bloodSugar = bloodSugarController.text;
                        });
                      },
                      isNumber: false,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    'Allergies :',
                    style: TextStyle(fontSize: 15),
                  )),
                  Expanded(
                    flex: 6,
                    child: FormItem(
                      hintText: 'Enter Allergies ',
                      controller: allergiesController,
                      onChanged: () {
                        print('Name Saved');
                        setState(() {
                          allergies = allergiesController.text;
                        });
                      },
                      isNumber: false,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                print('Changed');
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(50, 20, 50, 30),
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 65.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.greenAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 3.0,
                      offset: Offset(0, 4.0),
                    ),
                  ],
                ),
                child: Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ],
        ));
  }
}
