import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallsAndMessagesService {
  void call(String number) => launch("tel:$number");
  void sendSms(String number) => launch("sms:+'91'+$number");
}
