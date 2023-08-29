
import 'dart:io';

import 'package:assignmentvideo/Utils/ComponentsColors.dart';
import 'package:assignmentvideo/Utils/general_utils.dart';
import 'package:assignmentvideo/widgets/UpperWidget.dart';
import 'package:assignmentvideo/widgets/Videoes.dart';
import 'package:assignmentvideo/widgets/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();


}



class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }




  // List<VideoPlayerController> videoControllers = [];




  @override
  Widget build(BuildContext context) {


    Future<List<DocumentSnapshot>> getAllDocuments() async {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Videos').get();
      print(querySnapshot.docs);
      return querySnapshot.docs;
    }
    print("whole build home page");
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getVideoFile(ImageSource.camera);

        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            UpperWidget(),
            FutureBuilder<List<DocumentSnapshot>>(
              future: getAllDocuments(),
              builder: (BuildContext context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loading indicator while retrieving data
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                List<DocumentSnapshot> documents = snapshot.data ?? [];

                print(snapshot.data);

                // Initialize VideoPlayerControllers
                List<VideoPlayerController> videoControllers = documents.map((doc) {
                  String videoUrl = doc['videoUrl'];
                  return VideoPlayerController.network(videoUrl);
                }).toList();

                return Expanded(
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Display each document's data here
                      return Column(
                        children: [

                          Padding(
                            padding:  EdgeInsets.only(top: mq.height*0.001),
                            child: Container(
                              height: mq.height*0.45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ComponentsColor.borderColorTextformfield,
                                  width: 2.0, // Adjust the border width as needed
                                ),

                              ),


                              child: Column(
                                children: [
                                  Container(
                                    height: 1,
                                    color: ComponentsColor.borderColorTextformfield,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: mq.width*0.01,right: mq.width*0.015,top: mq.height*0.002),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          child: Icon(Icons.dangerous),
                                        ),
                                        SizedBox(width: mq.width*0.02,),
                                        Text("ayush",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),),
                                        Spacer(),
                                        Icon(Icons.pin_drop),
                                        Text("maharastra")

                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    color: ComponentsColor.borderColorTextformfield,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: videoControllers[index].value.isInitialized
                                          ? VideoPlayer(videoControllers[index])
                                          : CircularProgressIndicator(),
                                    ), // Display loading indicator until video is initialized
                                  ),
                                    // child: Image.asset("assets/images/male.jpg"),
                                    //   ),
                                  Container(
                                    height: 1,
                                    color: ComponentsColor.borderColorTextformfield,
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(left: mq.width*0.01),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(documents[index]['title'],
                                        style: TextStyle(
                                            fontSize: 16
                                        ),),),
                                  ),
                                  Container(
                                    height: 1,
                                    color: ComponentsColor.borderColorTextformfield,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: mq.width*0.01,right: mq.width*0.015,bottom: mq.height*0.002),
                                    child: Row(
                                      children: [
                                        Icon(Icons.thumb_up),
                                        SizedBox(width: mq.width*0.02,),
                                        Text("56"),
                                        Spacer(),
                                        Text("2 days ago")
                                      ],
                                    ),

                                  )
                                ],
                              ),

                            ),
                          )
                        ],


                      );

                    },
                  ),
                );
              },
            )

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


}
