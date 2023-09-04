import "package:assignmentvideo/Model/videoModel.dart";
import "package:assignmentvideo/Utils/ComponentsColors.dart";
import "package:assignmentvideo/widgets/videoPlayerWidget.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";


class VideoThumbnail extends StatefulWidget {
  final videoModel videoData;

  const VideoThumbnail({Key? key, required this.videoData}) : super(key: key);

  @override
  State<VideoThumbnail> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
     bool loaded =false;
    print("the thumbnail is"+widget.videoData.thumbnailUrl);

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
                backgroundImage: AssetImage("assets/images/i1.png",),
              ),
              SizedBox(width: mq.width*0.02,),
              Text(widget.videoData.by,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),),
              Spacer(),
              Icon(Icons.pin_drop),
              Text(widget.videoData.location)

            ],
          ),
        ),
        Container(
          height: 1,
          color: ComponentsColor.borderColorTextformfield,
        ),

        SizedBox(
          height: mq.height*0.4,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [

              CachedNetworkImage(
                imageUrl: widget.videoData.thumbnailUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                      child: Container(
                        height: mq.height*0.01,
                        width: mq.width*0.6,
                        child: LinearProgressIndicator(
                          value: downloadProgress.progress,
                          backgroundColor: Colors.grey, // Customize the background color
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Customize the progress color
                        ),
                      ),
                    ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      VideoPlayerWidget(widget.videoData.videoUrl,widget.videoData.title,widget.videoData.location,widget.videoData.by,"rgng456")
                    ),

                  );

                },
                child: Center(
                  child: Icon(Icons.play_circle_filled_rounded,
                    color: Colors.white,
                    size: 64,)
                ),
              )




            ],

          )
        ),

        Container(
          height: 1,
          color: ComponentsColor.borderColorTextformfield,
        ),
        Padding(
          padding:  EdgeInsets.only(left: mq.width*0.01),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(widget.videoData.title,
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
  }
}
