import 'package:elderly_app/models/location.dart';
import 'package:elderly_app/others/constants.dart';
import 'package:elderly_app/others/network.dart';

class HospitalData {
  UserLocation userLocation;
  List<Hospital> hospitalList;
  HospitalData();
  getNearbyHospital() async {
    this.hospitalList = List<Hospital>();
    userLocation = UserLocation();
    await userLocation.getLocation().then((value) {
      this.userLocation = value;
    });
    String url =
        'https://api.tomtom.com/search/2/nearbySearch/.JSON?key=$kTomsApiKey&lat=${userLocation.latitude}&lon=${userLocation.longitude}&radius=2000&limit=10&categorySet=7321';
    NetworkHelper networkHelper = NetworkHelper(url);
    var data;
    await networkHelper.getData().then((value) {
      data = value;
    });
    var hospitals = data['results'];
    this.hospitalList = [];
    for (var h in hospitals) {
      String locationUrl = '', placeName = '';
      double locationLat = h['position']['lat'];
      double locationLon = h['position']['lon'];
      String uri =
          'https://api.opencagedata.com/geocode/v1/json?q=$locationLat+$locationLon&key=f29cf18b10224e27b8931981380b747a';
      NetworkHelper _networkHelper = NetworkHelper(uri);
      var _data;
      await _networkHelper.getData().then((value) {
        _data = value;
      });
      var hosData = _data['results'][0];
      placeName = hosData['components']['road'];
      locationUrl = hosData['annotations']['OSM']['url'];
      uri =
          'https://api.tomtom.com/routing/1/calculateRoute/${userLocation.latitude},${userLocation.longitude}:$locationLat,$locationLon/json?key=G5IOmgbhnBgevPJeglEK2zGJyYv6TG1Z';
      NetworkHelper _network = NetworkHelper(uri);
      var distanceData;
      await _network.getData().then((value) {
        distanceData = value;
      });

      double hospitalDistance =
          distanceData['routes'][0]['summary']['lengthInMeters'] / 1000;

      Hospital hospital = Hospital(h['poi']['name'], h['position']['lat'],
          h['position']['lon'], locationUrl, placeName, hospitalDistance);
      if (!this.hospitalList.contains(hospital)) {
        try {
          this.hospitalList.add(hospital);
        } catch (e) {
          print(e);
        }
      }
    }
    for (var h in this.hospitalList) {
      if (h != this.hospitalList.last) if (h ==
          this.hospitalList[this.hospitalList.indexOf(h) + 1])
        this.hospitalList.remove(h);
    }
    return this;
  }
}

class Hospital {
  String hospitalName, hospitalLocationUrl, hospitalPlace;
  double hospitalLocationLatitude, hospitalLocationLongitude, hospitalDistance;

  Hospital(this.hospitalName, this.hospitalLocationLatitude,
      this.hospitalLocationLongitude,
      [this.hospitalLocationUrl, this.hospitalPlace, this.hospitalDistance]);
}
