class User {
  String _userName;
  int _age;
  String _gender;
  int _height, _weight;
  String _bloodGroup, _bloodPressure, _bloodSugar;

  User(this._userName, this._age, this._bloodGroup, this._bloodPressure,
      this._bloodSugar, this._gender, this._height, this._weight);

  int get age => _age;
  int get height => _height;
  int get weight => _weight;
  String get bloodGroup => _bloodGroup;
  String get bloodPressure => _bloodPressure;
  String get userName => _userName;
  String get gender => _gender;
  String get bloodSugar => _bloodSugar;
}
