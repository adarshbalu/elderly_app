import 'package:flutter/material.dart';

double getDeviceHeight(BuildContext context) {
  MediaQueryData deviceInfo = MediaQuery.of(context);
  return deviceInfo.size.height;
}

double getDeviceWidth(BuildContext context) {
  MediaQueryData deviceInfo = MediaQuery.of(context);
  return deviceInfo.size.width;
}
