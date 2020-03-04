import 'dart:io';

class Reminder {
  int _id;
  String _reminderName;
  String _reminderType;
  int _times;
  String _time1, _time2, _time3;
  String _reminderOn;
  File _image;

  Reminder(this._reminderName, this._reminderType, this._time1, this._time2,
      this._time3, this._times, this._reminderOn,
      [this._image]);

  Reminder.withId(this._id, this._reminderName, this._reminderType, this._time1,
      this._time2, this._time3, this._times, this._reminderOn,
      [this._image]);

  int get id => _id;
  int get times => _times;

  String get reminderName => _reminderName;

  String get reminderType => _reminderType;

  String get time3 => _time3;

  String get time2 => _time2;

  String get time1 => _time1;

  String get reminderOn => _reminderOn;

  File get image => _image;

  set reminderName(String newReminderName) {
    if (newReminderName.length <= 255) {
      this._reminderName = newReminderName;
    }
  }

  set reminderType(String newReminderType) {
    if (newReminderType.length <= 255) {
      this._reminderType = newReminderType;
    }
  }

  set reminderOn(String newReminderOn) {
    if (newReminderOn == 'Daily' ||
        newReminderOn == 'Weekly' ||
        newReminderOn == 'Monthly') {
      this._reminderOn = newReminderOn;
    }
  }

  set time1(String newTime1) {
    this._time1 = newTime1;
  }

  set time2(String newTime2) {
    this._time2 = newTime2;
  }

  set time3(String newTime3) {
    this._time3 = newTime3;
  }

  set times(int newTimes) {
    if (newTimes > 0 && newTimes < 4) {
      this._times = newTimes;
    }
  }

  set image(File newImage) {
    this._image = newImage;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['reminderName'] = _reminderName;
    map['reminderType'] = _reminderType;
    map['reminderOn'] = _reminderOn;
    map['image'] = _image;
    map['times'] = _times;
    map['time1'] = _time1;
    map['time2'] = _time2;
    map['time3'] = _time3;
    return map;
  }

  Reminder.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._time1 = map['time1'];
    this._time2 = map['time2'];
    this._time3 = map['time3'];
    this._times = map['times'];
    this._image = map['image'];
    this._reminderOn = map['reminderOn'];
    this._reminderType = map['reminderType'];
    this._reminderName = map['reminderName'];
  }
}
