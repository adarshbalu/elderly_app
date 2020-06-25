import 'package:cloud_firestore/cloud_firestore.dart';

class TrackerModel {
  Sleep sleepTracker;
  WeightTracker weightTracker;
  HeightTracker heightTracker;
  BloodPressureTracker bloodPressureTracker;
  BloodSugarTracker bloodSugarTracker;
  TrackerModel();
}

class Sleep {
  int hours, minutes;
  String notes;
  DateTime dateTime;

  Sleep({this.hours, this.minutes, this.notes, this.dateTime});
}

class SleepTracker {
  bool isTracking;
  Sleep sleepData;
  SleepTracker();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['dateAndTime'] = this.sleepData.dateTime.toString();
    map['hours'] = this.sleepData.hours.toString();
    map['minutes'] = this.sleepData.minutes.toString();
    map['notes'] = this.sleepData.notes;

    return map;
  }

  fromMap(Map<String, dynamic> map) {
    Sleep sleepTracker = Sleep();
    sleepTracker.dateTime = DateTime.parse(map['dateAndTime']);
    sleepTracker.hours = int.parse(map['hours']);
    sleepTracker.minutes = int.parse(map['minutes']);
    sleepTracker.notes = map['notes'];
    return sleepTracker;
  }

  List<Sleep> loadData(QuerySnapshot snapshot) {
    List<DocumentSnapshot> documents = snapshot.documents;
    List<Sleep> sleepList = [];
    for (var data in documents) {
      Map map = data.data;
      sleepList.add(this.fromMap(map));
    }
    return sleepList;
  }
}

class WeightTracker {
  List<Tracker> weightTracker;
  bool isTracking;
}

class HeightTracker {
  List<Tracker> heightTracker;
  bool isTracking;
}

class BloodSugarTracker {}

class BloodPressureTracker {}

class Tracker {
  String dateAndTime;
  double value;
  String notes;
  Tracker({this.value, this.dateAndTime, this.notes});
}
