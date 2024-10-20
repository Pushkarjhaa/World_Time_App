import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments
            as Map; //we take that passing data in this function
    // print("${data['location']}");

    //set backgroung image
    String bgImage =
        data["isDaytime"] ? "day.jpg" : "night.jpg"; //Ternary operator
    Color bgcolor = data["isDaytime"]
        ? const Color.fromARGB(255, 151, 236, 226)
        : const Color.fromARGB(255, 1, 19, 34);
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/$bgImage"), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 110.0, 0, 0),
            child: Center(
              child: Column(
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      dynamic result =
                          await Navigator.pushNamed(context, "/chooselocation");
                      setState(() {
                        data = {
                          'time': result["time"],
                          "location": result["location"],
                          "isDaytime": result["isDaytime"],
                          "flag": result["flag"],
                        };
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Edit Location",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data["location"],
                        style: TextStyle(
                            fontSize: 28.0,
                            letterSpacing: 2.0,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    data["time"],
                    style: TextStyle(fontSize: 66.0, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
