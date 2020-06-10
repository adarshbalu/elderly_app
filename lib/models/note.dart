class Note {
  int _id;
  String _title;
  String _description;
  String _dateCreated;
  String _date;
  int _priority;

  Note(this._title, this._date, this._dateCreated, this._priority,
      [this._description]);

  Note.withId(this._id, this._title, this._dateCreated, this._priority,
      [this._description]);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  int get priority => _priority;

  String get dateCreated => _dateCreated;

  String get date => _date;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set dateCreated(String newDateCreated) {
    this._dateCreated = newDateCreated;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['dateCreated'] = _dateCreated;
    map['date'] = _date;
    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._dateCreated = map['dateCreated'];
    this._date = map['date'];
  }
}
