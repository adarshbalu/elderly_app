import 'package:geolocator/geolocator.dart';

class UserLocation {
  double latitude, longitude;
  UserLocation();
  getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    this.latitude = position.latitude;
    this.longitude = position.longitude;
    return this;
  }
}
