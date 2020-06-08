import 'package:elderly_app/models/note.dart';
import 'package:elderly_app/others/database_helper.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {
  static const String id = 'Note_Edit_Screen';
  final String appBarTitle;
  final Note note;

  NoteDetail(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
//  static var _priorities = ['High', 'Low'];

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Note note;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  NoteDetailState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;

    titleController.text = note.title;
    descriptionController.text = note.description;

    return WillPopScope(
        onWillPop: () async {
          moveToLastScreen();
          return true;
        },
        child: Hero(
          tag: note.id,
          child: Scaffold(
            appBar: ElderlyAppBar(),
            drawer: AppDrawer(),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.save,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        _save();
                      });
                    },
                  ),
                  Text(note.date),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        _delete();
                      });
                    },
                  )
                ],
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(
                  top: 10.0, left: 10.0, right: 10.0, bottom: 10),
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8, right: 8, top: 15.0, bottom: 0),
                        child: TextField(
                          controller: titleController,
                          style: textStyle.copyWith(fontSize: 21),
                          onChanged: (value) {
                            updateTitle();
                          },
                          decoration: InputDecoration(
                            hintText: 'Title',
                            labelStyle: textStyle.copyWith(fontSize: 21),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8, right: 8, top: 0, bottom: 15.0),
                        child: TextField(
                          controller: descriptionController,
                          style: textStyle.copyWith(fontSize: 18),
                          onChanged: (value) {
                            updateDescription();
                          },
                          minLines: 5,
                          maxLines: 10,
                          decoration: InputDecoration(
                            hintText: 'Note',
                            labelStyle: textStyle.copyWith(fontSize: 18),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

//  void updatePriorityAsInt(String value) {
//    switch (value) {
//      case 'High':
//        note.priority = 1;
//        break;
//      case 'Low':
//        note.priority = 2;
//        break;
//    }
//  }
//
//  String getPriorityAsString(int value) {
//    String priority;
//    switch (value) {
//      case 1:
//        priority = _priorities[0]; // 'High'
//        break;
//      case 2:
//        priority = _priorities[1]; // 'Low'
//        break;
//    }
//    return priority;
//  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDescription() {
    note.description = descriptionController.text;
  }

  void _save() async {
    moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      result = await helper.updateNote(note);
    } else {
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  void _delete() async {
    moveToLastScreen();

    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    int result = await helper.deleteNote(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occurred while Deleting Note');
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
