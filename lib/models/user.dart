import 'package:elderly_app/models/relative.dart';

class UserProfile {
  String allergies,
      userName,
      age,
      gender,
      bloodGroup,
      bloodPressure,
      bloodSugar,
      email,
      height,
      weight,
      phoneNumber,
      picture,
      uid;
  List<Relative> relatives;
  UserProfile(this.uid);
  setData(Map<String, dynamic> data) {
    this.uid = data['uid'];
    this.phoneNumber = data['phoneNumber'];
    this.age = data['age'];
    this.bloodGroup = data['bloodGroup'];
    this.bloodPressure = data['bloodPressure'];
    this.bloodSugar = data['bloodSugar'];
    this.email = data['email'];
    this.gender = data['gender'];
    this.height = data['height'];
    this.picture = data['picture'];
    this.weight = data['weight'];
    this.userName = data['userName'];
    this.allergies = data['allergies'];
    return this;
  }

  getAllRelatives(var data) {
    this.relatives = List<Relative>();
    for (var relative in data) {
      Relative _relative = Relative();
      _relative.getData(relative);
      this.relatives.add(_relative);
    }
  }
}
