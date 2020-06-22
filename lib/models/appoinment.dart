class Appoinment {
  int _id;
  String _name;
  String _place;
  String _address;
  String _dateAndTime;
  int _notificationID;
  bool _done;

  Appoinment(this._name, this._place, this._dateAndTime, this._address,
      this._notificationID, this._done);

  Appoinment.withId(this._id, this._name, this._place, this._dateAndTime,
      this._address, this._notificationID, this._done);

  int get id => _id;
  String get address => _address;

  String get name => _name;

  String get place => _place;

  String get dateAndTime => _dateAndTime;

  bool get done => _done;

  int get notificationId => _notificationID;

  set name(String newName) {
    if (newName.length <= 255) {
      this._name = newName;
    }
  }

  set place(String newPlace) {
    if (newPlace.length <= 255) {
      this._place = newPlace;
    }
  }

  set dateAndTime(String newTime) {
    this._dateAndTime = newTime;
  }

  set address(String newAddress) {
    this._address = newAddress;
  }

  set notificationId(int nId) {
    this._notificationID = nId;
  }

  set done(bool value) {
    this._done = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['place'] = _place;
    map['address'] = _address;
    map['date_time'] = _dateAndTime;
    map['notification_id'] = _notificationID;
    map['done'] = done == true ? 1 : 0;
    return map;
  }

  Appoinment.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._dateAndTime = map['date_time'];
    this._address = map['address'];
    this._place = map['place'];
    this._name = map['name'];
    this._notificationID = map['notification_id'];
    this._done = map['done'] == 1;
  }
}
