import 'package:assignmentvideo/Model/videoModel.dart';
import 'package:assignmentvideo/Utils/ComponentsColors.dart';
import 'package:assignmentvideo/widgets/UpperWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl,title,location,name,postTime;

  VideoPlayerWidget(this.videoUrl, this.title, this.location, this.name, this.postTime);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    initillizedVideo();
  }

  @override
  Widget build(BuildContext context) {
    print("The url of the video is:-"+widget.videoUrl);
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text("Video Player"),),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                if(_controller.value.isPlaying){
                  _controller.pause();
                }else{
                  _controller.play();
                }

              },
              child: Container(
                height: mq.height*0.5,

                child: _controller.value.isInitialized
                    ? VideoPlayer(_controller)
                    : Center(child: CircularProgressIndicator()),
              ),
            ),
            Container(
              height: 1,
              color: ComponentsColor.borderColorTextformfield,
            ),
            Container(
              child: Padding(
                padding:  EdgeInsets.only(left: 10,top: 2),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(widget.title,style: TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.bold
                  ),),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 10,right: 10,top: 10),
              child: Container(
                height: 1,
                color:Colors.black,
              ),
            ),
            Container(
              child: Padding(
                padding:  EdgeInsets.only(left: 10,right: 10,top: 10),
                child: Row(
                  children: [
                    Icon(Icons.thumb_up),
                    Spacer(),
                    Icon(Icons.thumb_down),
                    Spacer(),
                    Icon(Icons.share),

                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 10,right: 10,top: 10),
              child: Container(
                height: 1,
                color:Colors.black,
              ),
            ),
            Container(
              child: Padding(
                padding:  EdgeInsets.only(left: 10,right: 10,top: 10),
                child: Row(
                  children: [
                    Icon(Icons.remove_red_eye),
                    Text("  5",style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),),
                    Spacer(),
                    Text("2 days ago",style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),)

                  ],
                ),
              ),
            ),

            Container(
              child: Padding(
                padding:  EdgeInsets.only(left: 10,right: 10,top: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/g1.jpg"),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 10),
                      child: Text("Ayush kumar",style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    Spacer(),
                    Padding(
                      padding:  EdgeInsets.only(right: 10),
                      child: Text("View all videos",style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),),
                    )

                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 10,right: 10,top: 10),
              child: Container(
                height: 1,
                color:Colors.black,
              ),
            ),
            Container(
              child: Padding(
                padding:  EdgeInsets.only(left: 10,right: 10,top: 10),
                child: TextFormField(

                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.send,color: Colors.blue,
                    size: 32,),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Comment',
                    hintStyle: TextStyle(color: Colors.black),
                  ),

                ),
              ),
            ),



          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }


  void initillizedVideo() async {
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {


        if (!_controller.value.isPlaying) {
          setState(() {
            _controller.play();
            _controller.setLooping(true);

            // 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

          });

          // For example, you might want to play the video
        }
        // _controller.play();

        // _controller.play();
      });
  }
}