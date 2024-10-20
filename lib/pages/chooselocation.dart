import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<World_time> locations = [
    World_time(url: "Asia/kolkata", location: "Kolkata", flag: "india.png"),
    World_time(url: "Asia/Seoul", location: "Seoul", flag: "south_korea.png"),
    World_time(url: "Asia/Jakarta", location: "Jakarta", flag: "indonesia.png"),
    World_time(url: "Europe/London", location: "London", flag: "uk.png"),
    World_time(url: "Europe/Berlin", location: "Athens", flag: "greece.png"),
    World_time(url: "America/Chicago", location: "Chicago", flag: "usa.png"),
    World_time(url: "America/New_York", location: "New York", flag: "usa.png"),
    World_time(url: "Arica/Nairobi", location: "Nairobi", flag: "kenya.png")
  ];
  void updateTime(index) async {
    World_time instance = locations[index];
    await instance.getTime();
    //navigate to home screen
    Navigator.pop(context, {
      "location": instance.location,
      "flag": instance.flag,
      "time": instance.time,
      "isDaytime": instance.isDaytime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(220, 238, 238, 238),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Choose Location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (Context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text(locations[index].location.toString()),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/${locations[index].flag}"),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
