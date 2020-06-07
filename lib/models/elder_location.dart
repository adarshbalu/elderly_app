import 'package:elderly_app/models/location.dart';
import 'package:elderly_app/others/constants.dart';
import 'package:elderly_app/others/network.dart';

class ElderLocation {
  String address, url;
  ElderLocation();
  getLocationData(UserLocation location) async {
    String uri =
        'https://api.opencagedata.com/geocode/v1/json?q=${location.latitude}+${location.longitude}&key=$kOpenCageApiKey';
    NetworkHelper networkHelper = NetworkHelper(uri);
    var data = await networkHelper.getData();
    this.url = data['results'][0]['annotations']['OSM']['url'];
    this.address = data['results'][0]['formatted'];
    return this;
  }
}
