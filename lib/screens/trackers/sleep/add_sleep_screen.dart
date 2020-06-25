import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddSleepScreen extends StatefulWidget {
  @override
  _AddSleepScreenState createState() => _AddSleepScreenState();
}

class _AddSleepScreenState extends State<AddSleepScreen> {
  final _trackerKey = GlobalKey<FormState>();
  TextEditingController hours, minutes, notes;

  @override
  void initState() {
    hours = TextEditingController(text: '');
    notes = TextEditingController(text: '');
    minutes = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Text(
                  'Add Sleep Data',
                  style: TextStyle(
                    fontSize: 32,
                    color: Color(0xff3d5afe),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _trackerKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: hours,
                            decoration: InputDecoration(
                              hintText: 'Hours Slept',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              disabledBorder: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                            ),
                            onChanged: (v) {
                              _trackerKey.currentState.validate();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter minutes';
                              } else {
                                if (!isNumeric(value)) {
                                  return 'Enter numeric value';
                                }
                                if (int.parse(value) < 0) {
                                  return 'Value too small';
                                }
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: minutes,
                            onChanged: (v) {
                              _trackerKey.currentState.validate();
                            },
                            decoration: InputDecoration(
                              hintText: 'Minutes Slept',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              disabledBorder: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter minutes';
                              } else {
                                if (!isNumeric(value)) {
                                  return 'Enter numeric value';
                                }
                                if (int.parse(value) < 0) {
                                  return 'Value too small';
                                }
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: TextFormField(
                      onChanged: (v) {
                        _trackerKey.currentState.validate();
                      },
                      controller: notes,
                      decoration: InputDecoration(
                        hintText: 'Notes about sleep ',
                        border: OutlineInputBorder(),
                        disabledBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter value';
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton.icon(
                color: Color(0xff3d5afe),
                onPressed: () {},
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                icon: Icon(Icons.add),
                label: Text('Add Data')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Recommended sleep time is 8 hours.'),
            )
          ],
        ),
      ),
      appBar: ElderlyAppBar(),
      drawer: AppDrawer(),
    );
  }
}

//_registerFormKey.currentState.validate();

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return int.tryParse(s) != null;
}
