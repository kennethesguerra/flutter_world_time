import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time;
  String flag;
  String url;
  bool error;
  bool isDaytime;


  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {
    try {
      //make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      //get the properties
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      time = DateFormat.jm().format(now);
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      error = false;
    }
    catch (e) {
      print('caugt error: $e');
      time = 'Could not get the right time';
      error = true;
    }

  }
}
