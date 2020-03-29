class Image {
  int _id;
  String _name;
  String _location;

  Image(this._name, [this._location]);

  Image.withId(this._id, this._name, [this._location]);

  int get id => _id;

  String get name => _name;

  String get location => _location;

  set name(String newName) {
    if (newName.length <= 255) {
      this._name = newName;
    }
  }

  set location(String newLocation) {
    if (newLocation.length <= 255) {
      this._location = newLocation;
    }
  }

  // Convert a Image object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['location'] = _location;
    return map;
  }

  // Extract a Image object from a Map object
  Image.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._location = map['location'];
  }
}
