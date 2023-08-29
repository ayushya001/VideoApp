import 'dart:io';

import 'package:assignmentvideo/Model/videoModel.dart';
import 'package:assignmentvideo/Utils/ComponentsColors.dart';
import 'package:assignmentvideo/widgets/UpperWidget.dart';
import 'package:assignmentvideo/widgets/upload.dart';
import 'package:assignmentvideo/widgets/videoPlayerWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

    final mq = MediaQuery.of(context).size;


    return  Scaffold(

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
            Expanded(
              child: FutureBuilder<List<videoModel>>(
                future: fetchVideosFromFirestore(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No videos available.'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        videoModel video = snapshot.data![index];

                        return Column(
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
                            AspectRatio(
                            aspectRatio: 16 / 9,
                            child: VideoPlayerWidget(video.videoUrl),
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
                                child: Text(video.title,
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
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///for fututre
  // AspectRatio(
  // aspectRatio: 16 / 9,
  // child: VideoPlayerWidget(video.videoUrl),
  // ),


    Future<List<videoModel>> fetchVideosFromFirestore() async {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('Videos').get();

      print("we get"+await FirebaseFirestore.instance.collection('Videos').get().toString());

      List<videoModel> videos = [];
      snapshot.docs.forEach((doc) {
        videos.add(videoModel(
          title: doc['title'],
          time: doc['PublishDateandtime'],
          videoId: doc['videoId'],
          videoUrl: doc['videoUrl'],
        ));
      });

      return videos;

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
