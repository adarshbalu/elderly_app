class TrackerModel {
  SleepTracker sleepTracker;
  WeightTracker weightTracker;
  HeightTracker heightTracker;
  BloodPressureTracker bloodPressureTracker;
  BloodSugarTracker bloodSugarTracker;
  TrackerModel();
}

class SleepTracker {
  int hours, minutes;
  bool isTracking;
  String notes;
  SleepTracker();

  getAllTrackingData() {
    if (this.isTracking)
      return this;
    else
      return '';
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
