import 'package:cloud_firestore/cloud_firestore.dart';

class TrackerModel {
  Sleep sleepTracker;
  WeightTracker weightTracker;
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

class Weight {
  int weight;
  String notes;
  DateTime dateTime;

  Weight({this.weight, this.notes, this.dateTime});
}

class WeightTracker {
  bool isTracking;
  Weight weightData;
  WeightTracker();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['dateAndTime'] = this.weightData.dateTime.toString();
    map['weight'] = this.weightData.weight.toString();
    map['notes'] = this.weightData.notes;

    return map;
  }

  fromMap(Map<String, dynamic> map) {
    Weight weightTracker = Weight();
    weightTracker.dateTime = DateTime.parse(map['dateAndTime']);
    weightTracker.weight = int.parse(map['weight']);

    weightTracker.notes = map['notes'];
    return weightTracker;
  }

  List<Weight> loadData(QuerySnapshot snapshot) {
    List<DocumentSnapshot> documents = snapshot.documents;
    List<Weight> weightList = [];
    for (var data in documents) {
      Map map = data.data;
      weightList.add(this.fromMap(map));
    }
    return weightList;
  }
}

class BloodSugar {
  int bloodSugar;
  String notes;
  DateTime dateTime;
  BloodSugar({this.bloodSugar, this.notes, this.dateTime});
}

class BloodSugarTracker {
  bool isTracking;
  BloodSugar bloodSugar;
  BloodSugarTracker();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['dateAndTime'] = this.bloodSugar.dateTime.toString();
    map['blood_sugar'] = this.bloodSugar.bloodSugar.toString();
    map['notes'] = this.bloodSugar.notes;

    return map;
  }

  fromMap(Map<String, dynamic> map) {
    BloodSugar bloodSugar = BloodSugar();
    bloodSugar.dateTime = DateTime.parse(map['dateAndTime']);
    bloodSugar.bloodSugar = int.parse(map['blood_sugar']);

    bloodSugar.notes = map['notes'];
    return bloodSugar;
  }

  List<BloodSugar> loadData(QuerySnapshot snapshot) {
    List<DocumentSnapshot> documents = snapshot.documents;
    List<BloodSugar> bloodSugarList = [];
    for (var data in documents) {
      Map map = data.data;
      bloodSugarList.add(this.fromMap(map));
    }
    return bloodSugarList;
  }
}

class BloodPressureTracker {}
