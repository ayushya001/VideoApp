import 'dart:io';

import 'package:assignmentvideo/Model/videoModel.dart';
import 'package:assignmentvideo/Utils/ComponentsColors.dart';
import 'package:assignmentvideo/widgets/UpperWidget.dart';
import 'package:assignmentvideo/widgets/VideoThumbnail.dart';
import 'package:assignmentvideo/widgets/upload.dart';
import 'package:assignmentvideo/widgets/videoPlayerWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homes extends StatefulWidget {
  const homes({Key? key}) : super(key: key);

  @override
  State<homes> createState() => _homesState();
}

class _homesState extends State<homes> {



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<videoModel>  videos =[];


    final mq = MediaQuery.of(context).size;



    return  Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getVideoFile(ImageSource.camera);
          getLocation();

        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),

      body: SafeArea(
        child: Column(
          children: [
            UpperWidget(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Videos").snapshots(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print("this is still waiting");
                        }
                  else if (snapshot.connectionState == ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {

                    if (snapshot.hasError) {
                      return const Text('Error');
                    }
                    else if (snapshot.hasData) {
                      print("this mean snapshot has data");


                      // final data = snapshot.data?.docs;
                      final data = snapshot.data!.docs;

                      videos = data
                          .map((e) => videoModel.fromJson(e.data() as Map<String, dynamic>))
                          .toList();

                      // print("the length of chatuser is"+ chatuser.toString());


                      return ListView.builder(
                        itemCount: videos.length,
                        itemBuilder: ( context, index) {

                          return  VideoThumbnail(videoData: videos[index],);
                        },
                      );
                    } else {
                      return const Text('No data available.'); // Handle case when snapshot has no data
                    }
                  }
                  return const Text('Unknown error');

                  }

              ),
            ),
          ],
        ),
      ),
    );
  }


  void getVideoFile(ImageSource sourceImg) async {
    final videoFile = await ImagePicker().pickVideo(source: sourceImg);



    if (videoFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              uploadform(
                  videoFile: File(videoFile.path), videoPath: videoFile.path
              ),
        ),

      );
    }
  }
  void getLocation() async {
    LocationPermission Curentpermission = await Geolocator.requestPermission();


    // Permission granted, get the current location
    try {
      LocationPermission permission = await Geolocator.checkPermission();


      if(permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever){
        print("Permission is not given");
        LocationPermission Curentpermission = await Geolocator.requestPermission();
      }else{
        Position currentPosition = await Geolocator.getCurrentPosition
          (desiredAccuracy: LocationAccuracy.best);
        print("Longitude : "+currentPosition.longitude.toString());
        print("Latitude : "+currentPosition.latitude.toString());

        // Use reverse geocoding to get the city or village name
        List<Placemark> placemarks = await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);

        if (placemarks.isNotEmpty) {
           String? city = placemarks[0].locality; // City name
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('currentlocation', city!);
          String? village = placemarks[0].subLocality; // Village name (if available)

          print("City: $city");

        } else {
          print("No placemarks found");
        }
      }

    }
    catch (e) {
      print("Error getting location: $e");
    }

  }
}
