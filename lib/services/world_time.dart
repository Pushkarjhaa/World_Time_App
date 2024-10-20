import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class World_time {
  String? location; //Location name for the UI
  String? time; //The time in that location
  String? flag; //URL to an asset flag icon
  String? url; //location url for api endpoint
  bool? isDaytime;

  // Constructor of world_time class
  World_time({this.location, this.flag, this.url});

  Future<void> getTime() async {
    //Make Request
    try {
      Response response =
          await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // //Get Properties from data
      String datetime = data["datetime"];
      String offset1 = data["utc_offset"].substring(1, 3);
      String offset2 = data["utc_offset"].substring(4, 6);

      // // Create object of Datetime
      DateTime now = DateTime.parse(datetime);
      now = now.add(
          Duration(hours: int.parse(offset1), minutes: int.parse(offset2)));
      //Set the time properties
      isDaytime =
          now.hour > 6 && now.hour < 20 ? true : false; //ternary opertaor
      time = DateFormat.jm().format(now); //format time in more attractive way
    } catch (e) {
      print("Eroor is $e");
      time = "could not get the time data";
    }
  }
}
