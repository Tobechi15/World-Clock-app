import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  late String time;
  String flag;
  String url;
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try{

    Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
    Map data = jsonDecode(response.body);
    // if (kDebugMode) {
    //   print(data);
    // }
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);
    // if (kDebugMode) {
    //   print('time is $datetime');
    //   print(offset);
    // }

    // create datetime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));
    // if (kDebugMode) {
    //   print(now);
    // }

    // set time property
    isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    time = DateFormat.jm().format(now);

    }catch(e){
      if (kDebugMode) {
        print('caught error Tobechi $e');
        time = 'could not get time';
      }
    }
  }
}