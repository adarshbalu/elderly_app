import 'package:elderly_app/others/network.dart';

class ElderLocation {
  String address, url;
  ElderLocation();
  getLocationData(String url) async {
    NetworkHelper networkHelper = NetworkHelper(url);
    var data = await networkHelper.getData();
    this.url = data['results'][0]['annotations']['OSM']['url'];
    this.address = data['results'][0]['formatted'];
  }
}
