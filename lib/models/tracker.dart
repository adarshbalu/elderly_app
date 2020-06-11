class TrackerModel {
  SleepTracker sleepTracker;
  WeightTracker weightTracker;
  HeightTracker heightTracker;
  BloodPressureTracker bloodPressureTracker;
  BloodSugarTracker bloodSugarTracker;
  TrackerModel();
}

class SleepTracker {
  List<Tracker> sleepTracker;
  bool isTracking;
  SleepTracker();

  addValue(Tracker _tracker) {
    this.sleepTracker.add(_tracker);
    if (!this.isTracking) this.isTracking = true;
  }

  getAllTrackingData() {
    if (this.isTracking)
      return this.sleepTracker;
    else
      return [];
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
