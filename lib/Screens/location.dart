import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class locations extends StatefulWidget {
  const locations({Key? key}) : super(key: key);

  @override
  State<locations> createState() => _locationsState();
}


class _locationsState extends State<locations> {

  String location  = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // getLocation();

        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Text("The location is :-"+location)

      ),
    );
  }
}
