import 'package:geolocator/geolocator.dart';

class UserLocation {
  double latitude, longitude;
  UserLocation({this.latitude, this.longitude});
  Future<UserLocation> getLocation() async {
    UserLocation userLocation = UserLocation();
    try {
      Geolocator _geolocator = Geolocator()..forceAndroidLocationManager = true;

      Position pos;
      await _geolocator
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high)
          .then((value) {
        pos = value;
      });
      if (pos == null) {
        Position position;
        await _geolocator
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
            .then((value) {
          position = value;
        });
        userLocation.longitude = this.longitude = position.longitude;
        userLocation.latitude = this.latitude = position.latitude;
      } else {
        userLocation.longitude = this.longitude = pos.longitude;
        userLocation.latitude = this.latitude = pos.latitude;
      }
    } catch (e) {
      print(e);
    }
    return userLocation;
  }
}
